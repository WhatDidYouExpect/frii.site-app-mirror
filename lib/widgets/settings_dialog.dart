import 'package:flutter/material.dart';
import '../utils/theme_manager.dart';

class SettingsDialog extends StatefulWidget {
  final String? apiToken;
  final String? name;
  final String apiUrl;
  final Function({String? token, String? name, String? apiUrl}) onSave;

  const SettingsDialog({
    super.key,
    this.apiToken,
    this.name,
    required this.apiUrl,
    required this.onSave,
  });

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  String? selectedTheme;

  @override
  void initState() {
    super.initState();
    selectedTheme = 'Default'; // default selection
  }

  void _showCredits(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Credits'),
        content: const Text(
          'whatdidyouexpect was here!\n'
          'Thanks to ctih for actually creating frii.site!\n'
          'Thank you for using this app!',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokenController = TextEditingController(text: widget.apiToken ?? '');
    final nameController = TextEditingController(text: widget.name ?? '');
    final urlController = TextEditingController(text: widget.apiUrl);

    return AlertDialog(
      title: Row(
        children: [
          const Text('Settings'),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _showCredits(context),
            child: const Icon(Icons.info_outline, size: 20, color: Colors.white70),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: tokenController,
              decoration: const InputDecoration(
                labelText: 'API Token',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                labelText: 'API URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            // Theme dropdown
            DropdownButtonFormField<String>(
              value: selectedTheme,
              decoration: const InputDecoration(
                labelText: 'Select Theme',
                border: OutlineInputBorder(),
              ),
              items: availableThemes.keys
                  .map((themeName) => DropdownMenuItem(
                        value: themeName,
                        child: Text(themeName),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedTheme = value;
                  // Update the global theme immediately
                  if (value != null) {
                    setAppTheme(availableThemes[value]!);
                  }
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            widget.onSave(
              token: tokenController.text.trim(),
              name: nameController.text.trim(),
              apiUrl: urlController.text.trim(),
            );
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
