import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'utils/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ThemeData initialTheme = await loadSavedTheme();
  appThemeNotifier.value = initialTheme;
  print('Running main with theme applied');

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeData>(
      valueListenable: appThemeNotifier,
      builder: (context, theme, _) {
        print('Building MaterialApp with theme: ${theme.brightness}');
        return MaterialApp(
          title: 'Domain Dashboard',
          theme: theme,
          home: const DomainDashboard(),
        );
      },
    );
  }
}
