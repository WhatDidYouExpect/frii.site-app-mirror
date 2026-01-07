import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ValueNotifier<ThemeData> appThemeNotifier = ValueNotifier(_defaultTheme());

ThemeData _defaultTheme() => ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        secondary: Color.fromARGB(255, 38, 143, 255),
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 47, 47, 47),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 38, 143, 255),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );

final Map<String, ThemeData> availableThemes = {
  'Default': _defaultTheme(),
  'Halloween': ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Colors.orange,
      secondary: Colors.black,
    ),
    scaffoldBackgroundColor: const Color(0xFF1A1A1A),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF2A1A00),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  ),
};
Future<void> setAppTheme(String themeKey) async {
  if (!availableThemes.containsKey(themeKey)) return;

  final newTheme = availableThemes[themeKey]!;

  if (appThemeNotifier.value != newTheme) {
    appThemeNotifier.value = newTheme;
    print('Theme changed to: $themeKey');

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedTheme', themeKey);
  } else {
    print('Theme already set to: $themeKey');
  }
}

Future<ThemeData> loadSavedTheme() async {
  final prefs = await SharedPreferences.getInstance();
  final savedTheme = prefs.getString('selectedTheme');

  ThemeData themeToApply;

  if (savedTheme != null && availableThemes.containsKey(savedTheme)) {
    themeToApply = availableThemes[savedTheme]!;
    print('Loaded saved theme: $savedTheme');
  } else {
    themeToApply = getSeasonalTheme();
    print('No saved theme found, using seasonal/default theme');
  }

  return themeToApply;
}


ThemeData getSeasonalTheme() {
  final now = DateTime.now();

  if (now.month == 10 && now.day == 31) {
    return availableThemes['Halloween']!;
  }

  return _defaultTheme();
}
