import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VersionSettingsPage extends StatelessWidget {
  const VersionSettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.settingVersion),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(lang.version_text),
      ),
    );
  }
}
