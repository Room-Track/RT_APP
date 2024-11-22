import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UsageSettingsPage extends StatelessWidget {
  const UsageSettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.settingUsage),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Text(lang.usage_text.replaceAll('*', '\n')),
          ),
        ),
      ),
    );
  }
}
