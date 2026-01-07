import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'utils/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeData>(
      valueListenable: appThemeNotifier,
      builder: (context, theme, _) {
        return MaterialApp(
          title: 'Domain Dashboard',
          theme: theme,
          themeMode: ThemeMode.dark,
          home: const DomainDashboard(),
        );
      },
    );
  }
}
