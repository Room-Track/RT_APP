import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_track_flutterapp/providers/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_track_flutterapp/theme/lang.dart';

class LanguageSettingsPage extends ConsumerStatefulWidget {
  const LanguageSettingsPage({super.key});

  @override
  ConsumerState<LanguageSettingsPage> createState() =>
      _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends ConsumerState<LanguageSettingsPage> {
  String _selected = '';

  void _onTap(String name) {
    if (name == _selected) {
      return;
    }
    _selected = name;
    ref.read(themeProvider).changeLanguageCode(name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lang = AppLocalizations.of(context)!;
    _selected = ref.watch(themeProvider).languageCode;
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.settingLanguage),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(lang.settingLanguageSub),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: AppLocalizations.supportedLocales.length,
                itemBuilder: (context, index) {
                  final value =
                      AppLocalizations.supportedLocales[index].languageCode;
                  return ListTile(
                    title: Text("${LangScheme.namesByCode[value]}"),
                    trailing: _selected == value
                        ? Icon(Icons.check, color: theme.colorScheme.primary)
                        : null,
                    onTap: () {
                      _onTap(value);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
