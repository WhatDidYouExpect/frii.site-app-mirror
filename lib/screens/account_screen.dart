import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/profile_card.dart';

class AccountScreen extends StatefulWidget {
  final String apiUrl;
  final String apiToken;

  const AccountScreen({super.key, required this.apiUrl, required this.apiToken});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Map<String, dynamic>? _userProfile;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    if (widget.apiToken.isEmpty) return;
    try {
      final response = await http.get(
        Uri.parse('${widget.apiUrl}/api/user'),
        headers: {
          'X-API-Token': widget.apiToken,
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          _userProfile = jsonDecode(response.body);
          _loading = false;
        });
      } else {
        print('Failed to fetch user: ${response.statusCode}');
        setState(() => _loading = false);
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _userProfile == null
              ? const Center(child: Text('Failed to load profile'))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileCard(userData: _userProfile!),
                    ],
                  ),
                ),
    );
  }
}
