import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
final ValueNotifier<ThemeData> appThemeNotifier = ValueNotifier(_materialBlueTheme());
ThemeData _materialDarkTheme() => ThemeData.dark();
ThemeData _halloweenTheme() => ThemeData(
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

ThemeData _materialBlueTheme() => ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      colorScheme: ColorScheme.dark(
        primary: Colors.blue,
        secondary: Colors.lightBlueAccent,
      ),
      scaffoldBackgroundColor: Colors.deepPurple,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blueAccent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );

ThemeData _materialPurpleTheme() => ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.deepPurple,
      colorScheme: ColorScheme.dark(
        primary: Colors.deepPurple,
        secondary: Colors.lightBlueAccent,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.deepPurple,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );


final Map<String, ThemeData> availableThemes = {
  'Material Dark': _materialDarkTheme(),
  'Halloween': _halloweenTheme(),
  'frii.site': _materialBlueTheme(),
  'friii.site Purple': _materialPurpleTheme(),
};

Future<ThemeData> loadSavedTheme() async {
  final prefs = await SharedPreferences.getInstance();
  final savedTheme = prefs.getString('selectedTheme');

  ThemeData themeToApply;

  if (savedTheme != null && availableThemes.containsKey(savedTheme)) {
    themeToApply = availableThemes[savedTheme]!;
    print('Loaded saved theme: $savedTheme');
  } else {
    final now = DateTime.now();
    if (now.month == 10 && now.day == 31) {
      themeToApply = _halloweenTheme();
      print('No saved theme found, using Halloween theme');
    } else {
      themeToApply = _materialBlueTheme();
      print('No saved theme found, using Material Blue theme');
    }
  }

  appThemeNotifier.value = themeToApply;
  return themeToApply;
}


Future<void> setAppTheme(String themeName) async {
  if (!availableThemes.containsKey(themeName)) return;

  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('selectedTheme', themeName);

  appThemeNotifier.value = availableThemes[themeName]!;
}
