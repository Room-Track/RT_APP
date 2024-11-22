import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:room_track_flutterapp/providers/history.dart';
import 'package:room_track_flutterapp/providers/traduction.dart';
import 'package:room_track_flutterapp/types/local.dart';
import 'package:room_track_flutterapp/views/info/page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomListTile extends ConsumerWidget {
  final ThemeData theme;
  final BasicInfoType info;

  const CustomListTile({
    super.key,
    required this.theme,
    required this.info,
  });

  void _onPressedTile(BuildContext context, WidgetRef ref) {
    ref.read(historyProvider).pushHistory(info);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => InfoPage(basicInfo: info)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = AppLocalizations.of(context)!;

    return ListTile(
      splashColor: theme.colorScheme.secondary,
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      leading: SvgPicture.asset(
        info.icon,
        height: 35,
        width: 35,
        colorFilter: ColorFilter.mode(
          theme.colorScheme.onSurface,
          BlendMode.srcIn,
        ),
      ),
      title: Text(info.name.length < 20
          ? info.name
          : "${info.name.substring(0, 20)}..."),
      subtitle: Text(
        TraductionAPI.getPlaceType(info.type, lang),
        style: TextStyle(color: theme.colorScheme.secondary),
      ),
      onTap: () {
        _onPressedTile(context, ref);
      },
    );
  }
}
