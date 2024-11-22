import 'package:flutter/material.dart';
import 'package:room_track_flutterapp/components/custom_star.dart';
import 'package:room_track_flutterapp/providers/traduction.dart';
import 'package:room_track_flutterapp/types/local.dart';
import 'package:room_track_flutterapp/views/info/lazy_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InfoPage extends StatelessWidget {
  final BasicInfoType basicInfo;
  const InfoPage({
    super.key,
    required this.basicInfo,
  });

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(TraductionAPI.getPlaceType(basicInfo.type, lang)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomStar(basicInfo: basicInfo),
          ),
        ],
      ),
      body: InfoLazyLayout(basicInfo: basicInfo),
    );
  }
}
