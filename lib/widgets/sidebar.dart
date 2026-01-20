import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class Sidebar extends StatelessWidget {
  final String? username;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const Sidebar({
    super.key,
    required this.username,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return NavigationDrawer(
      selectedIndex: selectedIndex,
      backgroundColor: colorScheme.surface,
      indicatorColor: colorScheme.primaryContainer,
      onDestinationSelected: (index) {
        onSelect(index);
        Navigator.pop(context);
      },
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 24, 16, 16),
          child: Text(
            username ?? 'User',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
        Divider(color: colorScheme.outlineVariant),
        _destination(
          icon: Icons.dashboard_outlined,
          selectedIcon: Icons.dashboard,
          label: l10n.drawerDashboard,
        ),
        _destination(
          icon: Icons.account_circle_outlined,
          selectedIcon: Icons.account_circle,
          label: l10n.drawerAccount,
        ),
        _destination(
          icon: Icons.computer_outlined,
          selectedIcon: Icons.computer,
          label: l10n.drawerLogs,
        ),
        _destination(
          icon: Icons.book_outlined,
          selectedIcon: Icons.book,
          label: l10n.drawerBlogs,
        ),
      ],
    );
  }

  NavigationDrawerDestination _destination({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
  }) {
    return NavigationDrawerDestination(
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      selectedIcon: Icon(
        selectedIcon,
        color: Colors.white,
      ),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
