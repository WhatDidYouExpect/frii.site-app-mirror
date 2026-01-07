import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void LogPrint(String message) {
  print(message);
  AppLogs.addLog(message);
}

class AppLogs {
  static final List<String> _logs = [];
  static final StreamController<List<String>> _controller =
      StreamController<List<String>>.broadcast();

  static void addLog(String log) {
    _logs.add(log);
    if (!_controller.isClosed) {
      _controller.add(List.from(_logs.reversed)); // Send reversed logs
    }
  }

  static Stream<List<String>> get logsStream => _controller.stream;

  static List<String> get logs => List.unmodifiable(_logs.reversed);
}

const bgColor = Color(0xFF121212);

class FriiApp extends StatelessWidget {
  const FriiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        cardColor: bgColor,
        brightness: Brightness.dark,
      ),
      home: const AppLogsScreen(),
    );
  }
}

class AppLogsScreen extends StatefulWidget {
  const AppLogsScreen({super.key});

  @override
  State<AppLogsScreen> createState() => _AppLogsScreenState();
}

class _AppLogsScreenState extends State<AppLogsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: StreamBuilder<List<String>>(
        stream: AppLogs.logsStream,
        initialData: AppLogs.logs,
        builder: (context, snapshot) {
          final logs = snapshot.data ?? [];
          final combinedLogs = logs.join('\n\n');

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onLongPress: () {
                Clipboard.setData(ClipboardData(text: combinedLogs));
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SelectableText(
                  combinedLogs.isEmpty ? 'No logs yet' : combinedLogs,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
