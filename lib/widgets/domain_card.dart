import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/date_formatter.dart';
import '../l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final valueController = TextEditingController(text: domainData['value'] ?? '');
    String selectedType = domainData['type'] ?? 'A';

    String userIp = '';
    try {
      final service = ApiService(apiUrl: apiUrl, apiToken: apiToken);
      userIp = await service.getUserIP();
    } catch (e) {
      userIp = l10n.unableToFetchIp;
    }

    final ipController = TextEditingController(text: userIp);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(l10n.modifyDomainTitle(_normalizeDomain(keyName))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancelButton),
            ),
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
                    SnackBar(content: Text(l10n.domainModifiedSuccess)),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${l10n.domainModifyError}: $e')),
                  );
                }
              },
              child: Text(l10n.saveButton),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteDomainTitle(_normalizeDomain(keyName))),
        content: Text(l10n.deleteDomainWarning),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancelButton)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              try {
                final service = ApiService(apiUrl: apiUrl, apiToken: apiToken);
                await service.deleteDomain(
                  domain: _normalizeDomain(keyName),
                  type: domainData['type'] ?? 'A',
                );
                onRefresh();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.domainDeletedSuccess)),
                );
              } catch (e) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${l10n.domainDeleteError}: $e')),
                );
              }
            },
            child: Text(l10n.deleteButton),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
            Text(
              _normalizeDomain(keyName),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('${l10n.ipLabel}: ', style: const TextStyle(fontSize: 14)),
                Expanded(
                  child: SelectableText(
                    domainData['ip'] ?? '',
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text('${l10n.lastUpdatedLabel}: ${formatDate(domainData['registered'])}',
                style: const TextStyle(fontSize: 14)),
            Text('${l10n.typeLabel}: ${domainData['type'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => _confirmDelete(context),
                  child: Text(l10n.deleteButton),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _showModifyDialog(context),
                  child: Text(l10n.modifyButton),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
