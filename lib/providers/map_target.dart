import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:room_track_flutterapp/http/app_fetch.dart';
import 'package:room_track_flutterapp/types/local.dart';
import 'package:room_track_flutterapp/types/path.dart';

class MapTargetNotifier extends ChangeNotifier {
  InfoPageType? generalInfo;
  LatLng? actualPos;
  double? alt;
  bool goToMap = false;
  bool fixedCamera = false;
  Future<PathData?> pathData;
  int closest;

  MapTargetNotifier({
    required this.generalInfo,
    required this.pathData,
    required this.closest,
  });

  void toggleFixed() {
    fixedCamera = !fixedCamera;
    notifyListeners();
  }

  void setActualPos(double lat, double lng, double alt) async {
    actualPos = LatLng(lat, lng);
    this.alt = alt;
    final PathData? data = await pathData;
    if (data != null) {
      PathNode? closestNode;
      double closestDistance = double.infinity;
      int closestIndex = -1;
      for (var entrie in data.path.indexed) {
        if (entrie.$1 < closest) continue;
        final doc = data.nodes[entrie.$2]!;
        final dist = sqrt(pow(doc.lat - lat, 2) +
            pow(doc.lng - lng, 2));
        if (dist <= closestDistance) {
          closestNode = doc;
          closestDistance = dist;
          closestIndex = entrie.$1;
        }
      }

      if (closestNode != null &&
          closestDistance * 100 * 1000 <= closestNode.rad) {
        closest = closestIndex;
      }
    }
    notifyListeners();
  }

  void changeTarget(InfoPageType info) async {
    generalInfo = info;
    goToMap = true;
    pathData = AppFetch.route(
      actualPos?.latitude.toString() ?? '',
      actualPos?.longitude.toString() ?? '',
      alt.toString(),
      info.name,
    );
    notifyListeners();
  }

  void mapReached() async {
    goToMap = false;
    notifyListeners();
  }

  void deleteTarget() {
    generalInfo = null;
    closest = -1;
    pathData = Future(() => null);
    generalInfo = null;
    notifyListeners();
  }

  void increment(int limit) {
    closest++;
    if (closest > limit) closest = limit;
    notifyListeners();
  }
}

final mapTargetProvider = ChangeNotifierProvider<MapTargetNotifier>((ref) {
  return MapTargetNotifier(
    generalInfo: null,
    pathData: Future(() => null),
    closest: -1,
  );
});
