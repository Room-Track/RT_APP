import 'package:flutter/material.dart';
import 'package:room_track_flutterapp/components/custom_server_error.dart';
import 'package:room_track_flutterapp/http/app_fetch.dart';
import 'package:room_track_flutterapp/types/local.dart';
import 'package:room_track_flutterapp/views/info/page_building.dart';
import 'package:room_track_flutterapp/views/info/page_regular_room.dart';
import 'package:room_track_flutterapp/views/info/skeleton_regular_room.dart';

class InfoLazyLayout extends StatefulWidget {
  final BasicInfoType basicInfo;
  const InfoLazyLayout({
    super.key,
    required this.basicInfo,
  });

  @override
  State<InfoLazyLayout> createState() => _InfoLazyLayoutState();
}

class _InfoLazyLayoutState extends State<InfoLazyLayout> {
  late Future<InfoPageType?> _fullInfo;

  @override
  void initState() {
    super.initState();
    _fullInfo = AppFetch.fullInfoPage(widget.basicInfo.name);
  }

  Widget _getInfoPage(InfoPageType full) {
    switch (widget.basicInfo.type) {
      case 'Building':
        return BuildingInfoPage(fullInfo: full);
      default:
        return RegularRoomInfoPage(fullInfo: full);
    }
  }

  Widget _getSkeleton() {
    switch (widget.basicInfo.type) {
      default:
        return RegularRoomSkeleton();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fullInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _getSkeleton();
          } else if (snapshot.hasData && snapshot.data != null) {
            return _getInfoPage(snapshot.data!);
          } else {
            return CustomServerError();
          }
        });
  }
}
