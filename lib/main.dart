import 'package:flutter/material.dart';
import 'utils/language_manager.dart';
import 'utils/theme_manager.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadSavedLocale();
  await loadSavedTheme();

  runApp(MyApp());
}
