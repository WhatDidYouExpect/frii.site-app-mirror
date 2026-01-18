import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<Locale> appLocaleNotifier = ValueNotifier(const Locale('en'));

Future<Locale> loadSavedLocale() async {
  final prefs = await SharedPreferences.getInstance();
  String? langCode = prefs.getString('selectedLanguage');

  // detect system locale if not already set
  if (langCode == null) {
    final systemLocale = PlatformDispatcher.instance.locale;
    langCode = systemLocale.languageCode;
    await prefs.setString('selectedLanguage', langCode);
    print('No saved locale found. Detected system locale: $langCode');
  }

  final locale = Locale(langCode);
  appLocaleNotifier.value = locale; // update notifier
  print('Loaded locale: $langCode'); // debug
  return locale;
}

Future<void> setAppLocale(String languageCode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('selectedLanguage', languageCode);
  final locale = Locale(languageCode);
  appLocaleNotifier.value = locale; // notify listeners
  print('Set new locale: $languageCode');
  final allPrefs =
      prefs.getKeys().map((k) => '$k=${prefs.get(k)}').join(', ');
  print('All SharedPreferences: $allPrefs');
}
