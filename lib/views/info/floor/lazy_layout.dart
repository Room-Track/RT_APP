import 'package:flutter/material.dart';
import 'package:room_track_flutterapp/components/custom_card.dart';
import 'package:room_track_flutterapp/components/custom_card_skeleton.dart';
import 'package:room_track_flutterapp/components/custom_server_error.dart';
import 'package:room_track_flutterapp/http/app_fetch.dart';
import 'package:room_track_flutterapp/types/interfaces.dart';
import 'package:room_track_flutterapp/types/local.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FloorLazyLayout extends StatefulWidget {
  final int num;
  final IRef refInfo;
  const FloorLazyLayout({
    super.key,
    required this.num,
    required this.refInfo,
  });

  @override
  State<FloorLazyLayout> createState() => _FloorLazyLayoutState();
}

class _FloorLazyLayoutState extends State<FloorLazyLayout> {
  late Future<Iterable<BasicInfoType>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData =
        AppFetch.basicInfoIterableFloor(widget.num, widget.refInfo.name);
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return FutureBuilder(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                title: Text("${lang.floor} ${widget.num} | ${widget.refInfo.name}"),
              ),
              body: SingleChildScrollView(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(5, (idx) => CustomCardSkeleton()),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text("${lang.floor} ${widget.num} | ${widget.refInfo.name}"),
              ),
              body: SingleChildScrollView(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ...snapshot.data!
                          .map((el) => CustomCard(info: el))
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(),
              body: CustomServerError(),
            );
          }
        });
  }
}
