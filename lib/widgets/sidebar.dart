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

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              username ?? 'User',
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          _item(context, Icons.dashboard, l10n.drawerDashboard, 0),
          _item(context, Icons.account_circle, l10n.drawerAccount, 1),
          _item(context, Icons.book, l10n.drawerBlogs, 3),
          _item(context, Icons.computer, l10n.drawerLogs, 2),
        ],
      ),
    );
  }

  Widget _item(
    BuildContext context,
    IconData icon,
    String title,
    int index,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: selectedIndex == index,
      onTap: () {
        onSelect(index);
        Navigator.pop(context);
      },
    );
  }
}
