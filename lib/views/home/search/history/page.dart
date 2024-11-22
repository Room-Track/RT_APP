import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_track_flutterapp/components/custom_card.dart';
import 'package:room_track_flutterapp/providers/history.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = List.from(ref.watch(historyProvider).history);
    final lang = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.history),
      ),
      body: data.isEmpty
          ? Center(child: Text(lang.try_search_room))
          : SingleChildScrollView(
              child: Align(
                alignment: Alignment.topCenter,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 10,
                  runSpacing: 10,
                  children: [...data.reversed.map((el) => CustomCard(info: el))],
                ),
              ),
            ),
    );
  }
}
