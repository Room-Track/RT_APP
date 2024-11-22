import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_track_flutterapp/providers/map_target.dart';
import 'package:room_track_flutterapp/types/path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomNav extends ConsumerStatefulWidget {
  final PathData data;
  const CustomNav({super.key, required this.data});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomNav();
}

class _CustomNav extends ConsumerState<CustomNav> {
  void _onTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          final lang = AppLocalizations.of(context)!;
          final theme = Theme.of(context);
          final provider = ref.watch(mapTargetProvider);
          return Scaffold(
            appBar: AppBar(
              title: Text(lang.indications),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: widget.data.route.indexed
                    .map(
                      (entrie) => Wrap(
                        children: [
                          entrie.$2 != widget.data.route.first
                              ? Divider()
                              : SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                entrie.$2.from.length < 12
                                    ? entrie.$2.from
                                    : "${entrie.$2.from.substring(0, 12)}..",
                                style: TextStyle(
                                  color: entrie.$1 <= provider.closest
                                      ? Color(0xff358FEB)
                                      : theme.colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Icon(Icons.arrow_forward),
                              const SizedBox(width: 12),
                              Text(
                                entrie.$2.to.length < 12
                                    ? entrie.$2.to
                                    : "${entrie.$2.to.substring(0, 12)}..",
                                style: TextStyle(
                                  color: entrie.$1 == provider.closest
                                      ? Colors.cyanAccent
                                      : entrie.$1 < provider.closest
                                          ? Color(0xff358FEB)
                                          : theme.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                entrie.$2.info,
                                style: TextStyle(
                                  color: entrie.$1 == provider.closest
                                      ? Colors.cyanAccent
                                      : entrie.$1 < provider.closest
                                          ? Color(0xff358FEB)
                                          : theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final provider = ref.watch(mapTargetProvider);
    if (widget.data.path.isEmpty) return SizedBox();
    final PathRoute? route =
        provider.closest >= 0 && provider.closest < widget.data.route.length
            ? widget.data.route.elementAt(provider.closest)
            : null;
    final String from = route?.from ?? '';
    final String to = route?.to ?? '';
    final String ind = route?.info ?? '';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: InkWell(
          onTap: _onTap,
          child: Wrap(
            children: [
              route != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          from.length < 15 ? from : from.substring(0, 15),
                          style: TextStyle(color: Color(0xff358FEB)),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.arrow_forward),
                        const SizedBox(width: 10),
                        Text(
                          to.length < 15 ? to : to.substring(0, 15),
                          style: TextStyle(color: Colors.cyanAccent),
                        ),
                      ],
                    )
                  : Align(
                      child: Text(
                        provider.closest < widget.data.route.length
                            ? widget.data.route.first.from
                            : lang.you_reached,
                        style: TextStyle(color: Colors.cyanAccent),
                      ),
                    ),
              Divider(),
              Align(
                alignment: Alignment.center,
                child: Text(
                  route != null
                      ? ind
                      : provider.closest < widget.data.route.length
                          ? lang.start_point
                          : lang.congrats,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
