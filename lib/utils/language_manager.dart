import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<Locale> appLocaleNotifier = ValueNotifier(const Locale('en'));

Future<Locale> loadSavedLocale() async {
  final prefs = await SharedPreferences.getInstance();
  final langCode = prefs.getString('selectedLanguage') ?? 'en';
  final locale = Locale(langCode);
  appLocaleNotifier.value = locale; // update notifier
  print('Loaded saved locale: $langCode'); // debug
  return locale;
}

Future<void> setAppLocale(String languageCode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('selectedLanguage', languageCode);
  final locale = Locale(languageCode);
  appLocaleNotifier.value = locale; // notify listeners
  print('Set new locale: $languageCode');
  final allPrefs = prefs.getKeys().map((k) => '$k=${prefs.get(k)}').join(', ');
  print('All SharedPreferences: $allPrefs');
}
