import 'package:flutter/material.dart';
import 'package:room_track_flutterapp/types/interfaces.dart';
import 'package:room_track_flutterapp/views/info/floor/lazy_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomFloorListTile extends StatelessWidget {
  final int num;
  final IRef refInfo;

  const CustomFloorListTile({
    super.key,
    required this.num,
    required this.refInfo,
  });

  void _onPressedTile(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FloorLazyLayout(num: num, refInfo: refInfo)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lang = AppLocalizations.of(context)!;
    return ListTile(
      splashColor: theme.colorScheme.secondary,
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      leading: Text(
        '$num',
        style: theme.textTheme.displaySmall,
        textAlign: TextAlign.start,
      ),
      title: Text(lang.floor),
      subtitle: Text(
        num < 0
            ? lang.underground
            : num > 1
                ? lang.take_stairs
                : lang.at_ground_level,
        style: TextStyle(color: theme.colorScheme.secondary),
      ),
      trailing: Icon(
        Icons.arrow_forward,
        size: 30,
      ),
      onTap: () {
        _onPressedTile(context);
      },
    );
  }
}
