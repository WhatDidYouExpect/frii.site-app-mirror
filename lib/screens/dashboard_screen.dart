import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import '../widgets/domain_card.dart';
import '../widgets/settings_dialog.dart';

class DomainDashboard extends StatefulWidget {
  const DomainDashboard({super.key});

  @override
  State<DomainDashboard> createState() => _DomainDashboardState();
}

class _DomainDashboardState extends State<DomainDashboard> {
  String? _apiToken;
  String? _name;
  String _apiUrl = 'https://api.frii.site';
  Map<String, dynamic>? _domains;
  String? _error;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _apiToken = prefs.getString('api_token');
      _name = prefs.getString('name') ?? 'John Doe';
      _apiUrl = prefs.getString('api_url') ?? _apiUrl;
    });
    if (_apiToken != null && _apiToken!.isNotEmpty) {
      _fetchDomains();
    }
  }

  Future<void> _saveSettings({String? token, String? name, String? apiUrl}) async {
    final prefs = await SharedPreferences.getInstance();
    if (token != null) await prefs.setString('api_token', token);
    if (name != null) await prefs.setString('name', name);
    if (apiUrl != null) await prefs.setString('api_url', apiUrl);
    setState(() {
      if (token != null) _apiToken = token;
      if (name != null) _name = name;
      if (apiUrl != null) _apiUrl = apiUrl;
    });
    if (token != null && token.isNotEmpty) {
      _fetchDomains();
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

      final service = ApiService(apiUrl: _apiUrl, apiToken: _apiToken!);
      final domains = await service.fetchDomains();
      setState(() => _domains = domains);
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
        apiUrl: _apiUrl,
        onSave: _saveSettings,
      ),
    );
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_apiToken == null)
              ElevatedButton.icon(
                onPressed: _showSettingsDialog,
                icon: const Icon(Icons.vpn_key),
                label: const Text('Enter API Key'),
              )
            else
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hello, ${_name ?? 'User'}!',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
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
                child: ListView(
                  children: _domains!.entries
                      .map((entry) => DomainCard(
                            keyName: entry.key,
                            domainData: entry.value,
                            apiToken: _apiToken!,
                            apiUrl: _apiUrl,
                            onRefresh: _fetchDomains,
                          ))
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
