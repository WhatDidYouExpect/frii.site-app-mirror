import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../services/api_service.dart';
import '../widgets/domain_card.dart';
import '../widgets/settings_dialog.dart';
import 'account_screen.dart';
import 'logs_screen.dart';
class DomainDashboard extends StatefulWidget {
  const DomainDashboard({super.key});

  @override
  State<DomainDashboard> createState() => _DomainDashboardState();
}

class _DomainDashboardState extends State<DomainDashboard> {
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('No Internet'),
        content: const Text('Your device is offline. Please check your connection.'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
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
          title: const Text('Register Domain'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: domainController,
                decoration: const InputDecoration(
                  labelText: 'Domain',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: valueController,
                decoration: const InputDecoration(
                  labelText: 'Value',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: selectedType,
                decoration: const InputDecoration(
                  labelText: 'Type',
                  border: OutlineInputBorder(),
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
                  decoration: const InputDecoration(
                    labelText: 'Your IP',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 4),
                ElevatedButton(
                  onPressed: () {
                    valueController.text = ipController.text;
                  },
                  child: const Text('Use Your IP as Value'),
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
                    const SnackBar(
                      content: Text(
                        'Domain must be: {name}.frii.site, {name}.pill.ovh, or {name}.arrh.ovh',
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
                    const SnackBar(content: Text('Domain registered successfully!')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              },
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hello, ${_name ?? 'User'}!',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    onPressed: _showRegisterDomainDialog,
                    label: const Text('Register Domain'),
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
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('frii.site'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchDomains,
            tooltip: 'Refresh Domains',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showSettingsDialog,
            tooltip: 'Settings',
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
              title: const Text('Dashboard'),
              selected: _selectedPageIndex == 0,
              onTap: () {
                setState(() {
                  _selectedPageIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Account'),
              selected: _selectedPageIndex == 1,
              onTap: () {
                setState(() {
                  _selectedPageIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.computer),
              title: const Text('Logs'),
              selected: _selectedPageIndex == 2,
              onTap: () {
                setState(() {
                  _selectedPageIndex = 2;
                });
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
