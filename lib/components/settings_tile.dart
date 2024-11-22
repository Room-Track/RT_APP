import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final VoidCallback onTap;
  final bool? exit;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.iconColor,
    this.exit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      leading: Icon(icon, color: iconColor),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        onTap();
        if (exit != null && exit!) Navigator.pop(context);
      },
    );
  }
}
