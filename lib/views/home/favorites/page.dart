import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_track_flutterapp/components/custom_card.dart';
import 'package:room_track_flutterapp/components/custom_card_skeleton.dart';
import 'package:room_track_flutterapp/components/custom_server_error.dart';
import 'package:room_track_flutterapp/providers/favorites.dart';

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({
    super.key,
  });

  @override
  ConsumerState<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.appBar0),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: FutureBuilder(
            future: ref.watch(favoritesProvider).favorites,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(8, (idx) => CustomCardSkeleton()),
                );
              } else if (snapshot.hasData) {
                return snapshot.data!.isEmpty
                    ? Center(child: Text(lang.no_fav))
                    : Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          ...snapshot.data!.map((el) => CustomCard(info: el))
                        ],
                      );
              } else {
                return CustomServerError(
                  message: lang.error_local_storage,
                );
              }
            }),
      ),
    );
  }
}
