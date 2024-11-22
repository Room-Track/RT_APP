import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_track_flutterapp/views/settings/contact.dart';
import 'package:room_track_flutterapp/views/settings/font.dart';
import 'package:room_track_flutterapp/views/settings/language.dart';
import 'package:room_track_flutterapp/views/settings/profile.dart';
import 'package:room_track_flutterapp/views/settings/theme.dart';
import 'package:room_track_flutterapp/views/settings/usage.dart';
import 'package:room_track_flutterapp/views/settings/version.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({super.key});

  void _onSelected(BuildContext context, String value) async {
    switch (value) {
      case "Profile":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProfileSettingsPage()));
        break;
      case "Language":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LanguageSettingsPage()));
        break;
      case "Font":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => FontSettingsPage()));
        break;
      case "Theme":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ThemeSettingsPage()));
        break;
      case "Usage":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UsageSettingsPage()));
        break;
      case "Share":
        await Share.shareUri(Uri.parse("https://github.com/ROOM-TRACK"));
        break;
      case "Contact":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ContactSettingsPage()));
        break;
      case "Version":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => VersionSettingsPage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return PopupMenuButton(
      onSelected: (value) {
        _onSelected(context, value);
      },
      itemBuilder: (context) {
        final User user = FirebaseAuth.instance.currentUser!;
        final bool verified = !user.isAnonymous;
        return verified
            ? [
                PopupMenuItem(
                  value: "Profile",
                  child: Text(lang.settingProfile),
                ),
                PopupMenuItem(
                  value: "Language",
                  child: Text(lang.settingLanguage),
                ),
                PopupMenuItem(
                  value: "Font",
                  child: Text(lang.settingFont),
                ),
                PopupMenuItem(
                  value: "Theme",
                  child: Text(lang.settingTheme),
                ),
                PopupMenuItem(
                  value: "Usage",
                  child: Text(lang.settingUsage),
                ),
                PopupMenuItem(
                  value: "Share",
                  child: Text(lang.settingShare),
                ),
                PopupMenuItem(
                  value: "Contact",
                  child: Text(lang.settingContact),
                ),
                PopupMenuItem(
                  value: "Version",
                  child: Text(lang.settingVersion),
                ),
              ]
            : [
                PopupMenuItem(
                  value: "Language",
                  child: Text(lang.settingLanguage),
                ),
                PopupMenuItem(
                  value: "Font",
                  child: Text(lang.settingFont),
                ),
                PopupMenuItem(
                  value: "Theme",
                  child: Text(lang.settingTheme),
                ),
                PopupMenuItem(
                  value: "Usage",
                  child: Text(lang.settingUsage),
                ),
                PopupMenuItem(
                  value: "Share",
                  child: Text(lang.settingShare),
                ),
                PopupMenuItem(
                  value: "Contact",
                  child: Text(lang.settingContact),
                ),
                PopupMenuItem(
                  value: "Version",
                  child: Text(lang.settingVersion),
                ),
              ];
      },
    );
  }
}
