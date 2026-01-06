import 'package:flutter/material.dart';
import '../utils/date_formatter.dart';

class ProfileCard extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ProfileCard({super.key, required this.userData});

  Widget _buildRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blueAccent),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildInitialAvatar(String username) {
    final initials = username.isNotEmpty
        ? username.trim().split(' ').map((e) => e[0].toUpperCase()).take(2).join()
        : '?';
    return CircleAvatar(
      radius: 24,
      backgroundColor: const Color.fromRGBO(38, 143, 255, 1),
      child: Text(
        initials,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final country = userData['country'] ?? {};
    final permissions = userData['permissions'] ?? {};
    final ownedTlds = (userData['owned-tlds'] as List<dynamic>?)?.join(', ') ?? 'None';

    return Card(
      color: const Color(0xFF2A2A2A),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildInitialAvatar(userData['username'] ?? ''),
                const SizedBox(width: 12),
                Text(
                  userData['username'] ?? 'Unknown',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(color: Colors.white24, height: 20),
            _buildRow(Icons.email, 'Email', userData['email'] ?? 'N/A'),
            _buildRow(Icons.language, 'Language', userData['lang'] ?? 'N/A'),
            _buildRow(Icons.location_on, 'City', country['city'] ?? 'N/A'),
            _buildRow(Icons.flag, 'Country', country['country_name'] ?? 'N/A'),
            _buildRow(Icons.calendar_today, 'Joined', formatDate(userData['created'])),
            _buildRow(Icons.security, '2FA Enabled', userData['mfa_enabled'] == true ? 'Yes' : 'No'),
            _buildRow(Icons.code, 'Referral Code', userData['referral-code'] ?? 'N/A'),
            _buildRow(Icons.people, 'Referred People', '${userData['referred-people'] ?? 0}'),
            const Divider(color: Colors.white24, height: 20),
            _buildRow(Icons.admin_panel_settings, 'Max Domains', '${permissions['max-domains'] ?? 0}'),
            _buildRow(Icons.subdirectory_arrow_right, 'Max Subdomains', '${permissions['max-subdomains'] ?? 0}'),
            _buildRow(Icons.details, 'User Details Access', '${permissions['userdetails'] ?? false}'),
            _buildRow(Icons.language, 'Owned TLDs', ownedTlds),
            _buildRow(Icons.discord, 'Discord Linked', userData['discord-linked'] == true ? 'Yes' : 'No'),
          ],
        ),
      ),
    );
  }
}
