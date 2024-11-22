// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:room_track_flutterapp/providers/map_icons.dart';
import 'package:room_track_flutterapp/providers/map_target.dart';
import 'package:room_track_flutterapp/views/home/map/target_map.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  static const LatLng _UTFSM = LatLng(-33.0357662, -71.5948377);
  static const double _zoom = 18.5;
  bool _fixedCamera = false;
  double? acc;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Location _location = Location();
  BitmapDescriptor? userIcon;
  bool _disposed = false;
  bool _mapTypeSatelite = true;

  Future<void> _cameraToPos(LatLng pos) async {
    final controller = await _controller.future;
    CameraPosition newPos = CameraPosition(
      target: pos,
      zoom: _zoom,
    );
    await controller.animateCamera(CameraUpdate.newCameraPosition(newPos));
  }

  Future<void> _getLocationUpdates() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) return;
    serviceEnabled = await _location.requestService();

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    _location.onLocationChanged.listen((data) {
      if (data.latitude == null ||
          data.longitude == null ||
          data.altitude == null ||
          _disposed) return;
      if (_fixedCamera) _cameraToPos(LatLng(data.latitude!, data.longitude!));
      ref.read(mapTargetProvider).setActualPos(
            data.latitude!,
            data.longitude!,
            data.altitude!,
          );
      acc = data.accuracy;
      setState(() {});
    });
  }

  void _setupData() async {
    final shared = await SharedPreferences.getInstance();
    userIcon = await MapIcons.get(MapIcons.user, 25, 40);
    if (!shared.containsKey('_mapTypeSatelite')) {
      await shared.setBool('_mapTypeSatelite', true);
    }
    _mapTypeSatelite = shared.getBool('_mapTypeSatelite')!;
    _getLocationUpdates();
  }

  @override
  void initState() {
    super.initState();
    _setupData();
  }

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
  }

  void _reached() async {
    ref.read(mapTargetProvider).mapReached();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(mapTargetProvider);
    if (provider.goToMap) {
      Future(() {
        _reached();
      });
    }
    final lang = AppLocalizations.of(context)!;

    return Scaffold(
      floatingActionButton: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Wrap(
            direction: Axis.vertical,
            children: [
              FutureBuilder(
                future: provider.pathData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return IconButton(
                      onPressed: () {
                        ref.read(mapTargetProvider).deleteTarget();
                      },
                      icon: Icon(Icons.cancel_outlined),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              IconButton(
                onPressed: () async {
                  _mapTypeSatelite = !_mapTypeSatelite;
                  final shared = await SharedPreferences.getInstance();
                  await shared.setBool('_mapTypeSatelite', _mapTypeSatelite);
                  setState(() {});
                },
                icon: Icon(
                  _mapTypeSatelite ? Icons.satellite_alt : Icons.terrain,
                ),
              ),
              IconButton(
                onPressed: () {
                  _fixedCamera = !_fixedCamera;
                  if (provider.actualPos != null && _fixedCamera) {
                    _cameraToPos(provider.actualPos!);
                  }
                  setState(() {});
                },
                icon:
                    Icon(_fixedCamera ? Icons.gps_fixed : Icons.gps_not_fixed),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: provider.actualPos == null
          ? Center(child: Text(lang.unable_to_find_current))
          : TargetMap(
              mapTypeSatelite: _mapTypeSatelite,
              controller: _controller,
              zoom: _zoom,
              UTFSM: _UTFSM,
              actualPos: provider.actualPos,
              acc: acc,
              userIcon: userIcon,
              future: provider.pathData,
              closest: provider.closest,
            ),
    );
  }
}
