import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_track_flutterapp/providers/theme.dart';
import 'package:room_track_flutterapp/theme/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeSettingsPage extends ConsumerStatefulWidget {
  const ThemeSettingsPage({super.key});

  @override
  ConsumerState<ThemeSettingsPage> createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends ConsumerState<ThemeSettingsPage> {
  String _selectedTheme = "";

  void _onTap(String name) {
    if (name == _selectedTheme) {
      return;
    }
    _selectedTheme = name;
    ref.read(themeProvider).changeColorSchemeName(name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lang = AppLocalizations.of(context)!;
    _selectedTheme = ref.watch(themeProvider).colorSchemeName;
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.settingTheme),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(lang.settingThemeSub),
            SizedBox(height: 20),
            Expanded(
                child: ListView.builder(
              itemCount: ColorThemes.names.length,
              itemBuilder: (context, index) {
                final name = ColorThemes.getName(lang, index);
                final value = ColorThemes.names[index];
                return ListTile(
                  title: Text(name),
                  trailing: _selectedTheme == value
                      ? Icon(Icons.check, color: theme.colorScheme.primary)
                      : null,
                  onTap: () {
                    _onTap(value);
                  },
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
