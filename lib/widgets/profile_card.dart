import 'package:flutter/material.dart';
import '../utils/date_formatter.dart';
import '../l10n/app_localizations.dart';

class ProfileCard extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ProfileCard({super.key, required this.userData});

  Widget _buildRow(String label, String value, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          if (icon != null) Icon(icon, size: 20, color: Colors.blueAccent),
          if (icon != null) const SizedBox(width: 8),
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
    final l10n = AppLocalizations.of(context)!;

    final country = userData['country'] ?? {};
    final permissions = userData['permissions'] ?? {};
    final ownedTlds = (userData['owned-tlds'] as List<dynamic>?)?.join(', ') ?? l10n.none;

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
                  userData['username'] ?? l10n.unknown,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(color: Colors.white24, height: 20),
            _buildRow(l10n.emailLabel, userData['email'] ?? l10n.notAvailable, icon: Icons.email),
            _buildRow(l10n.languageLabel, userData['lang'] ?? l10n.notAvailable, icon: Icons.language),
            _buildRow(l10n.cityLabel, country['city'] ?? l10n.notAvailable, icon: Icons.location_on),
            _buildRow(l10n.countryLabel, country['country_name'] ?? l10n.notAvailable, icon: Icons.flag),
            _buildRow(l10n.joinedLabel, formatDate(userData['created']), icon: Icons.calendar_today),
            _buildRow(l10n.twoFaEnabledLabel, userData['mfa_enabled'] == true ? l10n.yes : l10n.no, icon: Icons.security),
            _buildRow(l10n.referralCodeLabel, userData['referral-code'] ?? l10n.notAvailable, icon: Icons.code),
            _buildRow(l10n.referredPeopleLabel, '${userData['referred-people'] ?? 0}', icon: Icons.people),
            const Divider(color: Colors.white24, height: 20),
            _buildRow(l10n.maxDomainsLabel, '${permissions['max-domains'] ?? 0}', icon: Icons.admin_panel_settings),
            _buildRow(l10n.maxSubdomainsLabel, '${permissions['max-subdomains'] ?? 0}', icon: Icons.subdirectory_arrow_right),
            _buildRow(l10n.userDetailsAccessLabel, '${permissions['userdetails'] ?? false}', icon: Icons.details),
            _buildRow(l10n.ownedTldsLabel, ownedTlds, icon: Icons.language),
            _buildRow(l10n.discordLinkedLabel, userData['discord-linked'] == true ? l10n.yes : l10n.no, icon: Icons.discord),
          ],
        ),
      ),
    );
  }
}
