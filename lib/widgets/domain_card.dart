import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/date_formatter.dart';

class DomainCard extends StatelessWidget {
  final String keyName;
  final Map<String, dynamic> domainData;
  final String apiToken;
  final String apiUrl;
  final VoidCallback onRefresh;

  const DomainCard({
    super.key,
    required this.keyName,
    required this.domainData,
    required this.apiToken,
    required this.apiUrl,
    required this.onRefresh,
  });

  String _normalizeDomain(String domain) => domain.replaceAll('[dot]', '.');

  void _showModifyDialog(BuildContext context) async {
    final valueController = TextEditingController(text: domainData['value'] ?? '');
    String selectedType = domainData['type'] ?? 'A';

    String userIp = '';
    try {
      final service = ApiService(apiUrl: apiUrl, apiToken: apiToken);
      userIp = await service.getUserIP();
    } catch (e) {
      userIp = 'Unable to fetch IP';
    }

    final ipController = TextEditingController(text: userIp);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('Modify ${_normalizeDomain(keyName)}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: valueController,
                decoration: const InputDecoration(labelText: 'Value', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedType,
                decoration: const InputDecoration(labelText: 'Type', border: OutlineInputBorder()),
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
                  child: const Text('Update Domain to your IP'),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () async {
                try {
                  final service = ApiService(apiUrl: apiUrl, apiToken: apiToken);
                  await service.modifyDomain(
                    domain: _normalizeDomain(keyName),
                    type: selectedType,
                    value: valueController.text.trim(),
                  );
                  onRefresh();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Domain modified successfully!')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2A2A2A),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_normalizeDomain(keyName),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('IP: ', style: TextStyle(fontSize: 14)),
                Expanded(
                  child: SelectableText(
                    domainData['ip'] ?? '',
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text('Last Updated: ${formatDate(domainData['registered'])}',
                style: const TextStyle(fontSize: 14)),
            Text('Type: ${domainData['type'] ?? 'N/A'}', style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => _showModifyDialog(context),
                child: const Text('Modify'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
