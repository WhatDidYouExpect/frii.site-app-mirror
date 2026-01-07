import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../screens/logs_screen.dart';

class ApiService {
  final String apiUrl;
  final String apiToken;

  ApiService({required this.apiUrl, required this.apiToken});

  /// Check if device can reach the internet
  static Future<bool> hasInternetConnection() async {
    if (kIsWeb) {
      LogPrint("Client is a web browser! skipping network check.."); 
      return true;
    }
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  String _normalizeDomain(String domain) => domain.replaceAll('[dot]', '.');

  Future<Map<String, dynamic>> fetchDomains() async {
    if (!await hasInternetConnection()) {
      throw Exception('No internet connection');
    }

    final url = Uri.parse('$apiUrl/api/domains');

    final response = await http.get(
      url,
      headers: {'X-API-Token': apiToken, 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      if (data.containsKey('domains')) {
        data['domains'] = (data['domains'] as List)
            .map((d) => d.toString().replaceAll('[dot]', '.'))
            .toList();
      }
      return data;
    } else {
      LogPrint("Error ${response.statusCode}");
      throw Exception('Error ${response.statusCode}');
    }
  }

  Future<String> getUserIP() async {
    if (!await hasInternetConnection()) {
      LogPrint("No internet connection");
      throw Exception('No internet connection');
    }

    try {
      final response = await http.get(
        Uri.parse('https://api.ipify.org?format=json'),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        return data['ip'] ?? '';
      } else {
        LogPrint("Failed to fetch IP (${response.statusCode})");
        throw Exception('Failed to fetch IP (${response.statusCode})');
      }
    } catch (e) {
      LogPrint("Failed to fetch IP: $e");
      throw Exception('Failed to fetch IP: $e');
    }
  }

  Future<void> modifyDomain({
    required String domain,
    required String type,
    required String value,
  }) async {
    if (!await hasInternetConnection()) {
      LogPrint("No internet connection");
      throw Exception('No internet connection');
    }

    final normalizedDomain = _normalizeDomain(domain);

    final url = Uri.parse('$apiUrl/api/domain').replace(
      queryParameters: {
        'domain': normalizedDomain,
        'type': type,
        'value': value,
      },
    );

    final response = await http.patch(
      url,
      headers: {'X-API-Token': apiToken, 'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Error ${response.statusCode}');
    }
  }

  Future<void> registerDomain({
    required String domain,
    required String type,
    required String value,
  }) async {
    if (!await hasInternetConnection()) {
      LogPrint("No internet connection");
      throw Exception('No internet connection');
    }

    final url = Uri.parse('$apiUrl/api/domain');

    final body = json.encode({
      'domain': _normalizeDomain(domain),
      'type': type,
      'value': value,
    });

    final response = await http.post(
      url,
      headers: {
        'X-API-Token': apiToken,
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: body,
    );

    final Map<int, String> domainErrorMessages = {
      400: 'Invalid domain name.',
      403: 'Domain missing for subdomain (e.g., a.b.frii.site needs b.frii.site registered)',
      405: 'Domain limit exceeded.',
      409: 'Domain already in use.',
      412: 'Invalid DNS record type.',
      422: 'Validation Error.'
    };

    if (response.statusCode != 200 && response.statusCode != 201) {
      final statusCode = response.statusCode;
      final responseBody = response.body;
      final message = domainErrorMessages[statusCode] ??
          'Failed to register domain';
      LogPrint('Failed to register domain $domain\nStatus Code: $statusCode\nResponse Body:\n$responseBody');
      throw Exception('$message (Status Code: $statusCode)');
    }
  }

  Future<void> deleteDomain({
    required String domain,
    required String type,
  }) async {
    if (!await hasInternetConnection()) {
      throw Exception('No internet connection');
    }

    final url = Uri.parse('$apiUrl/api/domain').replace(
      queryParameters: {
        'domain': _normalizeDomain(domain),
        'type': type,
      },
    );

    final response = await http.delete(
      url,
      headers: {'X-API-Token': apiToken, 'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      LogPrint('Failed to delete domain: ${response.statusCode}');
      throw Exception('Failed to delete domain: ${response.statusCode}');
    }
  }
}
