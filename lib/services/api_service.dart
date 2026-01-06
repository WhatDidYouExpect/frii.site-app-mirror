import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ApiService {
  final String apiUrl;
  final String apiToken;

  ApiService({required this.apiUrl, required this.apiToken});

  /// Check if device can reach the internet
  static Future<bool> hasInternetConnection() async {
    if (kIsWeb) return true;
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
      throw Exception('Error ${response.statusCode}');
    }
  }

  Future<String> getUserIP() async {
    if (!await hasInternetConnection()) {
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
        throw Exception('Failed to fetch IP (${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Failed to fetch IP: $e');
    }
  }


  Future<void> modifyDomain({
    required String domain,
    required String type,
    required String value,
  }) async {
    if (!await hasInternetConnection()) {
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
}
