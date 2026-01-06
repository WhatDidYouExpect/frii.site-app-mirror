import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl;
  final String apiToken;

  ApiService({required this.apiUrl, required this.apiToken});

  Future<Map<String, dynamic>> fetchDomains() async {
    final url = Uri.parse('$apiUrl/api/domains');

    final response = await http.get(
      url,
      headers: {'X-API-Token': apiToken, 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error ${response.statusCode}');
    }
  }

  Future<void> modifyDomain({
    required String domain,
    required String type,
    required String value,
  }) async {
    final normalizedDomain = domain.replaceAll('[dot]', '.');
    final url = Uri.parse('$apiUrl/api/domain').replace(
      queryParameters: {'domain': normalizedDomain, 'type': type, 'value': value},
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
