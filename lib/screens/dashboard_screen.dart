import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../services/api_service.dart';
import '../l10n/app_localizations.dart';
import '../widgets/domain_card.dart';
import '../widgets/settings_dialog.dart';
import '../widgets/popup.dart';
import 'account_screen.dart';
import 'blog_screen.dart';
import 'logs_screen.dart';

class DomainDashboard extends StatefulWidget {
  const DomainDashboard({super.key});

  @override
  State<DomainDashboard> createState() => _DomainDashboardState();
}

class _DomainDashboardState extends State<DomainDashboard> {
  final String _donationPopupKey = 'donation_popup_shown';
  String? _apiToken;
  String? _name;
  String apiUrl = 'https://beta.frii.site';
  Map<String, dynamic>? _domains;
  String? _error;
  bool _loading = false;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _showDonationPopupOnce();
  }


  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _apiToken = prefs.getString('api_token');
      apiUrl = prefs.getString('api_url') ?? apiUrl;
      _name = prefs.getString('username');
    });

    if (_apiToken != null && _apiToken!.isNotEmpty) {
      await _fetchUserProfile();
      _fetchDomains();
    }
  }

  Future<void> _showDonationPopupOnce() async {
    final prefs = await SharedPreferences.getInstance();
    final shown = prefs.getBool(_donationPopupKey) ?? false;
    if (shown) return;

    final l10n = AppLocalizations.of(context)!;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => ConfigurablePopup(
          title: l10n.donationPopupTitle,
          text: l10n.donationPopupText,
          links: {l10n.donationPopupButton: 'https://ko-fi.com/ctih1'},
          extraActions: [
            TextButton(
              onPressed: () async {
                await prefs.setBool(_donationPopupKey, true);
                Navigator.of(context).pop();
              },
              child: Text(l10n.dontShowAgainButton),
            ),
          ],
        ),
      );
    });
  }


  Future<void> _saveSettings({String? token, String? name, String? apiUrl}) async {
    final prefs = await SharedPreferences.getInstance();
    if (token != null) await prefs.setString('api_token', token);
    if (apiUrl != null) await prefs.setString('api_url', apiUrl);

    setState(() {
      if (token != null) _apiToken = token;
      if (apiUrl != null) apiUrl = apiUrl;
    });

    if (_apiToken != null && _apiToken!.isNotEmpty) {
      await _fetchUserProfile(); // fetch username from API
      _fetchDomains();
    }
  }

  Future<void> _fetchUserProfile() async {
    if (_apiToken == null || _apiToken!.isEmpty) return;
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/api/user'),
        headers: {
          'X-API-Token': _apiToken!,
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['username'] != null) {
          setState(() {
            _name = data['username'];
          });
        }
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      LogPrint('Error fetching user profile: $e');
    }
  }

  Future<void> _fetchDomains() async {
    setState(() => _loading = true);
    try {
      final hasInternet = await ApiService.hasInternetConnection();
      if (!hasInternet) {
        _showNoInternetDialog();
        return;
      }
      final service = ApiService(apiUrl: apiUrl, apiToken: _apiToken!);
      final domains = await service.fetchDomains();
      setState(() => _domains = domains);
      LogPrint("Successfully fetched domains!");
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  void _showNoInternetDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.noInternetTitle),
        content: Text(l10n.noInternetMessage),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.okButton),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => SettingsDialog(
        apiToken: _apiToken,
        name: _name,
        apiUrl: apiUrl,
        onSave: _saveSettings,
      ),
    );
  }

  void _showRegisterDomainDialog() async {
    final l10n = AppLocalizations.of(context)!;
    final domainController = TextEditingController();
    final valueController = TextEditingController();
    String selectedType = 'A';
    String userIp = '';

    try {
      final service = ApiService(apiUrl: apiUrl, apiToken: _apiToken!);
      userIp = await service.getUserIP();
    } catch (e) {
      userIp = 'Unable to fetch IP';
    }

    final ipController = TextEditingController(text: userIp);

    bool isValidDomain(String domain) {
      LogPrint('Validating domain: "$domain"');
      final regex = RegExp(r'^[a-zA-Z0-9-]+\.(frii\.site|pill\.ovh|arrh\.ovh)$');
      final isValid = regex.hasMatch(domain);
      if (!isValid) {
        LogPrint('Regex check failed for "$domain"');
        return false;
      }
      LogPrint('Regex pass for "$domain"');
      return true;
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(l10n.registerDomainTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: domainController,
                decoration: InputDecoration(
                  labelText: l10n.domainLabel,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: valueController,
                decoration: InputDecoration(
                  labelText: l10n.valueLabel,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedType,
                decoration: InputDecoration(
                  labelText: l10n.typeLabel,
                  border: const OutlineInputBorder(),
                ),
                items: ['A', 'AAAA', 'CNAME', 'TXT', 'NS']
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => selectedType = value);
                },
              ),
              const SizedBox(height: 8),
              if (selectedType == 'A' || selectedType == 'AAAA') ...[
                TextField(
                  controller: ipController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: l10n.yourIpLabel,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 4),
                ElevatedButton(
                  onPressed: () {
                    valueController.text = ipController.text;
                  },
                  child: Text(l10n.useYourIpButton),
                ),
              ],
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                final domain = domainController.text.trim();

                if (!isValidDomain(domain)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        l10n.invalidDomainMessage(domain),
                      ),
                    ),
                  );
                  return;
                }

                try {
                  final service = ApiService(apiUrl: apiUrl, apiToken: _apiToken!);
                  await service.registerDomain(
                    domain: domain,
                    type: selectedType,
                    value: valueController.text.trim(),
                  );
                  _fetchDomains();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.domainRegisteredSuccess)),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${l10n.domainRegisterError}: $e')),
                  );
                }
              },
              child: Text(l10n.registerButton),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancelButton),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPage(int index) {
    final l10n = AppLocalizations.of(context)!;
    switch (index) {
      case 0:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  l10n.helloUser(_name ?? 'User'),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    onPressed: _showRegisterDomainDialog,
                    label: Text(l10n.registerDomainTitle),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (_loading) const CircularProgressIndicator(),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(_error!, style: const TextStyle(color: Colors.red)),
                ),
              if (_domains != null)
                Expanded(
                  child: ListView.builder(
                    itemCount: _domains!.length,
                    itemBuilder: (context, index) {
                      final entry = _domains!.entries.elementAt(index);
                      return DomainCard(
                        keyName: entry.key,
                        domainData: entry.value,
                        apiToken: _apiToken!,
                        apiUrl: apiUrl,
                        onRefresh: _fetchDomains,
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      case 1:
        return AccountScreen(apiToken: _apiToken!, apiUrl: apiUrl);
      case 2:
        return AppLogsScreen();
      case 3:
        return BlogScreen(apiUrl: apiUrl, apiToken: _apiToken!);
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appBarTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchDomains,
            tooltip: l10n.refreshDomainsTooltip,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showSettingsDialog,
            tooltip: l10n.settingsTooltip,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                _name ?? 'User',
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: Text(l10n.drawerDashboard),
              selected: _selectedPageIndex == 0,
              onTap: () {
                setState(() => _selectedPageIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text(l10n.drawerAccount),
              selected: _selectedPageIndex == 1,
              onTap: () {
                setState(() => _selectedPageIndex = 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: Text(l10n.drawerBlogs),
              selected: _selectedPageIndex == 3,
              onTap: () {
                setState(() => _selectedPageIndex = 3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.computer),
              title: Text(l10n.drawerLogs),
              selected: _selectedPageIndex == 2,
              onTap: () {
                setState(() => _selectedPageIndex = 2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _getPage(_selectedPageIndex),
    );
  }
}
