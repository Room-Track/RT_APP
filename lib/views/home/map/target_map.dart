// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:room_track_flutterapp/components/custom_nav.dart';
import 'package:room_track_flutterapp/types/path.dart';

class TargetMap extends StatefulWidget {
  final LatLng UTFSM;
  final double zoom;
  final bool mapTypeSatelite;
  final Completer<GoogleMapController> controller;
  final LatLng? actualPos;
  final double? acc;
  final BitmapDescriptor? userIcon;
  final Future<PathData?> future;
  final int closest;

  const TargetMap({
    super.key,
    required this.mapTypeSatelite,
    required this.controller,
    required this.actualPos,
    required this.acc,
    required this.userIcon,
    required this.zoom,
    required this.UTFSM,
    required this.future,
    required this.closest,
  });
  @override
  State<TargetMap> createState() => _TargetMapState();
}

class _TargetMapState extends State<TargetMap> {
  late CameraPosition initial;

  @override
  void initState() {
    super.initState();
    initial = CameraPosition(
      target: widget.UTFSM,
      zoom: widget.zoom,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshot) {
        final pathData = snapshot.data;

        final circles = pathData != null
            ? pathData.nodes.values.indexed
                .map(
                  (entries) => Circle(
                    circleId: CircleId(entries.$2.name),
                    center: LatLng(entries.$2.lat, entries.$2.lng),
                    radius: entries.$2.rad,
                    fillColor: (entries.$1 == widget.closest + 1
                            ? Colors.cyanAccent
                            : entries.$1 <= widget.closest
                                ? Color(0xff358FEB)
                                : entries.$2 == pathData.nodes.values.last
                                    ? Colors.redAccent
                                    : Colors.blueAccent)
                        .withOpacity(0.3),
                    strokeColor: (entries.$1 == widget.closest + 1
                            ? Colors.cyanAccent
                            : entries.$1 <= widget.closest
                                ? Color(0xff358FEB)
                                : entries.$2 == pathData.nodes.values.last
                                    ? Colors.redAccent
                                    : Colors.blueAccent)
                        .withOpacity(0.5),
                    strokeWidth: 5,
                    zIndex: 98,
                  ),
                )
                .toSet()
            : <Circle>{};

        final polylines = pathData != null
            ? pathData.polylines.indexed
                .map((el) => Polyline(
                      polylineId: PolylineId("Polyline${el.$1}"),
                      width: 5,
                      color: Colors.blue,
                      points: el.$2
                          .map((coords) => LatLng(
                                coords.first,
                                coords.last,
                              ))
                          .toList(),
                    ))
                .toSet()
            : <Polyline>{};

        final markers = pathData != null
            ? pathData.nodes.values.indexed
                .map(
                  (entrie) => Marker(
                    markerId: MarkerId(entrie.$2.name),
                    position: LatLng(entrie.$2.lat, entrie.$2.lng),
                    zIndex: 99,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      entrie.$1 == widget.closest + 1
                          ? BitmapDescriptor.hueCyan
                          : entrie.$1 <= widget.closest
                              ? BitmapDescriptor.hueAzure
                              : entrie.$2 == pathData.nodes.values.last
                                  ? BitmapDescriptor.hueRed
                                  : BitmapDescriptor.hueBlue,
                    ),
                    infoWindow: InfoWindow(title: entrie.$2.name),
                  ),
                )
                .toSet()
            : <Marker>{};

        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                compassEnabled: false,
                mapType:
                    widget.mapTypeSatelite ? MapType.satellite : MapType.normal,
                zoomControlsEnabled: false,
                onMapCreated: (control) {
                  widget.controller.complete(control);
                },
                initialCameraPosition: initial,
                circles: circles,
                polylines: polylines,
                markers: markers,
                onCameraMove: (pos) {
                  initial = pos;
                },
              ),
              pathData != null
                  ? Positioned.fill(
                      top: 0,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: CustomNav(data: pathData),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
