import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:room_track_flutterapp/providers/history.dart';
import 'package:room_track_flutterapp/providers/traduction.dart';
import 'package:room_track_flutterapp/types/local.dart';
import 'package:room_track_flutterapp/views/info/page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomCard extends ConsumerWidget {
  final BasicInfoType info;

  const CustomCard({
    super.key,
    required this.info,
  });

  void _onTap(BuildContext context, WidgetRef ref) {
    ref.read(historyProvider).pushHistory(info);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => InfoPage(basicInfo: info)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final lang = AppLocalizations.of(context)!;

    return Card(
      color: theme.colorScheme.surfaceDim,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          _onTap(context, ref);
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: 160,
            height: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /**
                 * name
                 */
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    info.name.length < 10
                        ? info.name
                        : "${info.name.substring(0, 9)}...",
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                /**
                 * Icon
                 */
                SvgPicture.asset(
                  info.icon,
                  width: 60,
                  height: 60,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
                /**
                 * type
                 */
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    TraductionAPI.getPlaceType(info.type, lang),
                    style: theme.textTheme.titleSmall,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
