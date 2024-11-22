import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_track_flutterapp/components/custom_list_tile.dart';
import 'package:room_track_flutterapp/components/custom_list_tile_skeleton.dart';
import 'package:room_track_flutterapp/components/custom_server_error.dart';
import 'package:room_track_flutterapp/http/app_fetch.dart';
import 'package:room_track_flutterapp/providers/search_query.dart';
import 'package:room_track_flutterapp/types/local.dart';

class SearchLazyLayout extends ConsumerStatefulWidget {
  const SearchLazyLayout({super.key});

  @override
  ConsumerState<SearchLazyLayout> createState() => _SearchLazyLayoutState();
}

class _SearchLazyLayoutState extends ConsumerState<SearchLazyLayout> {
  late Future<Iterable<BasicInfoType>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = Future(() => []);
  }

  void _refreshData(String query) {
    _futureData = AppFetch.basicInfoIterable(query);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = ref.watch(searchQueryProvider).query;
    if (query != '') {
      _refreshData(query.toUpperCase());
    }

    return FutureBuilder(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView(
              children: List.generate(10, (idx) => CustomListTileSkeleton()),
            );
          } else if (snapshot.hasData) {
            return ListView(
              children: [
                ...snapshot.data!
                    .map((el) => CustomListTile(theme: theme, info: el))
              ],
            );
          } else {
            return CustomServerError();
          }
        });
  }
}
