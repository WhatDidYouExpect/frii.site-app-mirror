import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
import '../utils/language_manager.dart';
import '../utils/theme_manager.dart';

class SettingsDialog extends StatefulWidget {
  final String? apiToken;
  final String? name;
  final String? apiUrl;
  final void Function({
    required String token,
    required String name,
    required String apiUrl,
  })? onSave;

  const SettingsDialog({
    super.key,
    this.apiToken,
    this.name,
    this.apiUrl,
    this.onSave,
  });

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  String? selectedTheme;
  String? selectedLanguage;

  @override
  void initState() {
    super.initState();
    selectedLanguage = appLocaleNotifier.value.languageCode;
    selectedTheme = availableThemes.entries
        .firstWhere(
          (entry) => entry.value == appThemeNotifier.value,
          orElse: () => MapEntry('Material Dark', availableThemes['Material Dark']!),
        )
        .key;
  }

  void _showCredits(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Credits'),
        content: const Text('whatdidyouexpect was here!\ncredits to ctih1!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokenController = TextEditingController(text: widget.apiToken ?? '');
    final nameController = TextEditingController(text: widget.name ?? '');
    final urlController = TextEditingController(text: widget.apiUrl ?? '');

    return AlertDialog(
      title: Row(
        children: [
          Text(l10n.settings),
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
              decoration: InputDecoration(
                labelText: l10n.apiToken,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: urlController,
              decoration: InputDecoration(
                labelText: l10n.apiUrl,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedLanguage,
              decoration: InputDecoration(
                labelText: l10n.selectLanguage,
                border: const OutlineInputBorder(),
              ),
              items: AppLocalizations.supportedLocales
                  .map((locale) => DropdownMenuItem(
                        value: locale.languageCode,
                        child: Text(locale.languageCode.toUpperCase()),
                      ))
                  .toList(),
              onChanged: (value) async {
                if (value != null) {
                  await setAppLocale(value);
                  setState(() => selectedLanguage = value);
                }
              },
            ),
            const SizedBox(height: 8),
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
                if (value != null) {
                  setState(() => selectedTheme = value);
                  setAppTheme(value);
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            if (widget.onSave != null) {
              widget.onSave!(
                token: tokenController.text.trim(),
                name: nameController.text.trim(),
                apiUrl: urlController.text.trim(),
              );
            }
            Navigator.pop(context);
          },
          child: Text(l10n.save),
        ),
      ],
    );
  }
}