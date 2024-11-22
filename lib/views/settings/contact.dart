import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSettingsPage extends StatelessWidget {
  const ContactSettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.settingContact),
      ),
      body: Center(
        child: Wrap(
          children: [
            TextButton.icon(
              onPressed: () async {
                await launchUrl(Uri.parse("https://github.com/ROOM-TRACK"));
              },
              label: Text("Github"),
              icon: SvgPicture.asset(
                'assets/button/github.svg',
                colorFilter:
                    ColorFilter.mode(Colors.blueAccent, BlendMode.srcIn),
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                final uri = Uri(
                    scheme: 'mailto',
                    path: 'mpenaloza@usm.cl',
                    query: 'subject=RoomTrack');
                await launchUrl(uri);
              },
              label: Text("Outlook"),
              icon: SvgPicture.asset(
                'assets/button/outlook.svg',
                colorFilter:
                    ColorFilter.mode(Colors.blueAccent, BlendMode.srcIn),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
