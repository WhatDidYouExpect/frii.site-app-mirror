import 'package:flutter/material.dart';

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

void setAppTheme(ThemeData newTheme) {
  appThemeNotifier.value = newTheme;
}

ThemeData getSeasonalTheme() {
  final now = DateTime.now();

  if (now.month == 10 && now.day == 31) {
    return ThemeData(
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
    );
  }

  return _defaultTheme();
}

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
