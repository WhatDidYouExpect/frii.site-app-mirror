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

class FriiApp extends StatelessWidget {
  const FriiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  Widget _buildLogCard(String log, int index) {
    return Card(
      color: const Color(0xFF2A2A2A),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: InkWell(
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: log));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Log copied to clipboard')),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Expanded(
                child: SelectableText(
                  log,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<String>>(
        stream: AppLogs.logsStream,
        initialData: AppLogs.logs,
        builder: (context, snapshot) {
          final logs = snapshot.data ?? [];
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: logs.length,
            itemBuilder: (context, index) {
              return _buildLogCard(logs[index], index);
            },
          );
        },
      ),
    );
  }
}
