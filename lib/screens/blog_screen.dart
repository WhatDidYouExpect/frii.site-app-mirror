import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_markdown/flutter_markdown.dart';
import '../l10n/app_localizations.dart';

class BlogScreen extends StatefulWidget {
  final String apiUrl;
  final String apiToken;

  const BlogScreen({
    super.key,
    required this.apiUrl,
    required this.apiToken,
  });

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  bool _loading = true;
  String? _error;
  List<dynamic> _posts = [];
  final Set<int> _expanded = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Safe to use context and l10n here
    final l10n = AppLocalizations.of(context)!;
    _fetchBlogs(l10n);
  }

  Future<void> _fetchBlogs(AppLocalizations l10n) async {
    setState(() => _loading = true);
    try {
      final response = await http.get(
        Uri.parse('${widget.apiUrl}/blog/get/all'),
        headers: {
          'Accept': 'application/json',
          'Accept-Language': Localizations.localeOf(context).languageCode,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _posts = jsonDecode(response.body);
          _loading = false;
        });
      } else {
        setState(() {
          _error = l10n.blogFailed(response.statusCode.toString());
          _loading = false;
        });
      }
    } catch (_) {
      setState(() {
        _error = l10n.blogError;
        _loading = false;
      });
    }
  }

  String _formatDate(int unixSeconds) {
    final date = DateTime.fromMillisecondsSinceEpoch(unixSeconds * 1000);
    return '${date.day}/${date.month}/${date.year}';
  }

  String _preview(String text, {int maxLength = 200}) {
    final clean = text.replaceAll(RegExp(r'\s+'), ' ');
    return clean.length > maxLength
        ? '${clean.substring(0, maxLength)}…'
        : clean;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: _loading
          ? Center(child: Text(l10n.blogLoading))
          : _error != null
              ? Center(child: Text(_error!))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _posts.length,
                  itemBuilder: (context, index) {
                    final post = _posts[index];
                    final isExpanded = _expanded.contains(index);

                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          setState(() {
                            isExpanded
                                ? _expanded.remove(index)
                                : _expanded.add(index);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post['title'],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _formatDate(post['date']),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.grey),
                              ),
                              const SizedBox(height: 12),
                              AnimatedCrossFade(
                                duration: const Duration(milliseconds: 250),
                                crossFadeState: isExpanded
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                firstChild: Text(
                                  _preview(post['body']),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                secondChild: MarkdownBody(
                                  data: post['body'],
                                  styleSheet:
                                      MarkdownStyleSheet.fromTheme(Theme.of(context)),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                isExpanded ? l10n.blogCollapse : l10n.blogReadMore,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
