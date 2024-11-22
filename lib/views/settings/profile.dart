import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_track_flutterapp/components/settings_tile.dart';
import 'package:room_track_flutterapp/theme/icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileSettingsPage extends StatelessWidget {
  ProfileSettingsPage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  String getUserName(String email) {
    return email.substring(0, email.indexOf("@"));
  }

  void onChangePassword(BuildContext context, AppLocalizations lang) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(lang.confirmation),
        content: Text(lang.this_will_send_mail),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                FirebaseAuth.instance
                    .sendPasswordResetEmail(email: user.email!);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(lang.mail_sended),
                  ),
                );
              },
              child: Text(lang.yes)),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(lang.no)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lang = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.settingProfile),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /**
               * Profile image
               */
              CircleAvatar(
                radius: 60,
                backgroundColor: theme.colorScheme.surfaceBright,
                backgroundImage: AssetImage(IconSchemePlaceHolder.profilePNG),
              ),
              SizedBox(height: 20),
              /**
               * Correo
               */
              Text("${user.email}", style: theme.textTheme.bodyMedium),
              SizedBox(height: 30),
              /**
               * Division
               */
              Divider(),
              /**
               * Change paswword
               */
              SettingsTile(
                icon: Icons.lock_outline,
                title: lang.settingProfileBtn1,
                onTap: () {
                  onChangePassword(context, lang);
                },
                iconColor: theme.colorScheme.primary,
              ),
              /**
               * Sign out
               */
              SettingsTile(
                icon: Icons.logout,
                title: lang.settingProfileBtn2,
                exit: true,
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
                iconColor: theme.colorScheme.error,
              )
            ],
          ),
        ),
      ),
    );
  }
}
