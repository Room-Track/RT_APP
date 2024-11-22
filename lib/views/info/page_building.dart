import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:room_track_flutterapp/components/custom_list_tile_floor.dart';
import 'package:room_track_flutterapp/providers/map_target.dart';
import 'package:room_track_flutterapp/types/local.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildingInfoPage extends ConsumerWidget {
  final InfoPageType fullInfo;
  const BuildingInfoPage({
    super.key,
    required this.fullInfo,
  });

  void _onMapTap(BuildContext context, WidgetRef ref, AppLocalizations lang) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(lang.appBar2),
          ),
          body: GoogleMap(
            mapType: MapType.satellite,
            initialCameraPosition: CameraPosition(
              zoom: 18,
              target: fullInfo.loc != null
                  ? LatLng(fullInfo.loc!.lat, fullInfo.loc!.lng)
                  : LatLng(double.tryParse(fullInfo.ref!.lat) ?? 0,
                      double.tryParse(fullInfo.ref!.lng) ?? 0),
            ),
            circles: {
              Circle(
                circleId: CircleId("Target"),
                center: fullInfo.loc != null
                    ? LatLng(fullInfo.loc!.lat, fullInfo.loc!.lng)
                    : LatLng(double.tryParse(fullInfo.ref!.lat) ?? 0,
                        double.tryParse(fullInfo.ref!.lng) ?? 0),
                radius: 5,
                zIndex: 99,
                strokeWidth: 5,
                fillColor: Colors.blueAccent.withOpacity(0.6),
                strokeColor: Colors.blueAccent.withOpacity(0.9),
              )
            },
          ),
        ),
      ),
    );
  }

  void _onGoTap(BuildContext context, WidgetRef ref) {
    Navigator.popUntil(context, (route) => route.isFirst);
    ref.read(mapTargetProvider).changeTarget(fullInfo);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final styleDesc = TextStyle(
      color: theme.colorScheme.secondary.withAlpha(200),
      fontWeight: theme.textTheme.titleLarge?.fontWeight,
      fontSize: theme.textTheme.titleLarge?.fontSize,
    );
    final lang = AppLocalizations.of(context)!;
    final floors = List.generate(
        fullInfo.ref!.highestF - fullInfo.ref!.lowestF + 1,
        (idx) => idx + fullInfo.ref!.lowestF).map(
      (idx) => idx != 0
          ? CustomFloorListTile(num: idx, refInfo: fullInfo.ref!)
          : SizedBox(),
    );
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /**
             * General Location
             */
            Text(
              lang.generalLocation,
              style: theme.textTheme.headlineLarge,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 200,
                    width: 200,
                    color: Colors.blueGrey,
                    child: fullInfo.loc != null || fullInfo.ref != null
                        ? Stack(
                            children: [
                              GoogleMap(
                                mapType: MapType.satellite,
                                mapToolbarEnabled: false,
                                compassEnabled: false,
                                rotateGesturesEnabled: false,
                                zoomGesturesEnabled: false,
                                tiltGesturesEnabled: false,
                                scrollGesturesEnabled: false,
                                zoomControlsEnabled: false,
                                initialCameraPosition: CameraPosition(
                                  zoom: 18,
                                  target: fullInfo.loc != null
                                      ? LatLng(
                                          fullInfo.loc!.lat, fullInfo.loc!.lng)
                                      : LatLng(
                                          double.tryParse(fullInfo.ref!.lat) ??
                                              0,
                                          double.tryParse(fullInfo.ref!.lng) ??
                                              0),
                                ),
                                circles: {
                                  Circle(
                                    circleId: CircleId("Target"),
                                    center: fullInfo.loc != null
                                        ? LatLng(fullInfo.loc!.lat,
                                            fullInfo.loc!.lng)
                                        : LatLng(
                                            double.tryParse(
                                                    fullInfo.ref!.lat) ??
                                                0,
                                            double.tryParse(
                                                    fullInfo.ref!.lng) ??
                                                0),
                                    radius: 5,
                                    zIndex: 99,
                                    strokeWidth: 5,
                                    fillColor:
                                        Colors.blueAccent.withOpacity(0.6),
                                    strokeColor:
                                        Colors.blueAccent.withOpacity(0.9),
                                  )
                                },
                              ),
                              Material(
                                type: MaterialType.transparency,
                                child: InkWell(
                                  onTap: () {
                                    _onMapTap(context, ref, lang);
                                  },
                                ),
                              )
                            ],
                          )
                        : Center(
                            child: Text(lang.no_info),
                          ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (fullInfo.ref != null) ...<Widget>[
                      Text(
                        lang.reference,
                        style: theme.textTheme.titleLarge,
                      ),
                      Text(
                        fullInfo.ref!.inside ? lang.inside : lang.outside,
                        style: styleDesc,
                      ),
                    ] else
                      SizedBox(height: 0),
                    const SizedBox(height: 10),
                    Text(
                      fullInfo.name,
                      style: theme.textTheme.titleLarge,
                    ),
                    SvgPicture.asset(
                      fullInfo.icon,
                      height: 30,
                      width: 30,
                      colorFilter: ColorFilter.mode(
                        theme.colorScheme.secondary.withAlpha(200),
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 50),
            /**
             * Go
             */
            TextButton(
              onPressed: () {
                _onGoTap(context, ref);
              },
              style: TextButton.styleFrom(
                overlayColor: theme.colorScheme.onPrimary,
                padding: const EdgeInsets.all(15),
                backgroundColor: theme.colorScheme.primary,
              ),
              child: Center(
                child: Text(
                  lang.go,
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                    fontSize: theme.textTheme.bodyLarge?.fontSize,
                    fontWeight: theme.textTheme.bodyLarge?.fontWeight,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            if (fullInfo.ref != null) ...<Widget>[
              /**
               * Floors
               */
              floors.length != 1
                  ? Text(
                      lang.floors,
                      style: theme.textTheme.headlineLarge,
                    )
                  : const SizedBox(),
              const SizedBox(height: 20),
              ...floors,
            ] else
              SizedBox(height: 0),
          ],
        ),
      ),
    );
  }
}
