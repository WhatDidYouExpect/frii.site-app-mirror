import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Configurable Popup Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ConfigurablePopup(
          title: 'Lorem Ispum!',
          text: 'Latin Blah Blah',
          links: {
            'Flutter': 'https://flutter.dev',
            'Dart': 'https://dart.dev',
            'OpenAI': 'https://expect.ovh',
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popup Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showPopup(context),
          child: const Text('Show Popup'),
        ),
      ),
    );
  }
}

class ConfigurablePopup extends StatelessWidget {
  final String title;
  final String text;
  final Map<String, String> links;
  final List<Widget>? extraActions;

  const ConfigurablePopup({
    super.key,
    required this.title,
    required this.text,
    required this.links,
    this.extraActions,
  });

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: [
        // material youing it so hard rn
        ...links.entries.map(
          (entry) => TextButton(
            onPressed: () => _launchURL(entry.value),
            child: Text(entry.key),
          ),
        ),

        ...?extraActions,

        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
