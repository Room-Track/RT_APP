import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:room_track_flutterapp/providers/search_query.dart';
import 'package:room_track_flutterapp/theme/icon.dart';
import 'package:room_track_flutterapp/views/home/search/building/lazy_layout.dart';
import 'package:room_track_flutterapp/views/home/search/history/page.dart';
import 'package:room_track_flutterapp/views/home/search/querylist/lazy_layout.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _animation;
  final FocusNode _focusNode = FocusNode();

  void _onChanged(String query) {
    ref.read(searchQueryProvider).changeQuery(query);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween<Alignment>(
      begin: Alignment.center,
      end: Alignment.topCenter,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future(() {
          _focusNode.requestFocus();
        });
      }
    });
  }

  void _onPressedSearchByBuilding(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SearchByBuildingLazy()));
  }

  void _onPressedSeeHistory(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HistoryPage()));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lang = AppLocalizations.of(context)!;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final delta = _animation.value.y - Alignment.topCenter.y;
        final step = 0.5;
        final halfDelta = 1 - (1 / step) * (1 - delta);

        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: theme.colorScheme.surface,
            leading: delta <= step
                ? Opacity(
                    opacity: 1 - delta,
                    child: IconButton(
                      onPressed: () {
                        _controller.reverse();
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  )
                : SizedBox(
                    height: 0,
                    width: 0,
                  ),
            title: delta <= step
                ? Opacity(
                    opacity: 1 - delta,
                    child: Text(lang.appBar1),
                  )
                : SizedBox(
                    width: 0,
                    height: 0,
                  ),
          ),
          body: Stack(
            children: [
              /**
               * Search List View
               */
              Column(
                children: [
                  SizedBox(height: 90),
                  Expanded(
                    child: SizedBox(
                      child: AbsorbPointer(
                        absorbing: delta != 0,
                        child: Opacity(
                          opacity: delta != 0 ? 0 : 1,
                          child: SearchLazyLayout(),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              /**
               * Animated Searchbar + Title + Options
               */
              Align(
                alignment: _animation.value,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 70 + 500 * delta,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /**
                         * Title
                         */
                        delta >= step
                            ? Opacity(
                                opacity: halfDelta,
                                child: Text(
                                  lang.welcome,
                                  style: theme.textTheme.headlineLarge,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : SizedBox(height: 0),
                        SizedBox(height: 20 * delta),
                        /**
                         * Searchbar
                         */
                        SearchBar(
                          onChanged: _onChanged,
                          autoFocus: false,
                          onTap: () {
                            if (delta != 0) {
                              _controller.forward();
                              _focusNode.unfocus();
                            }
                          },
                          onTapOutside: (ev) {
                            _focusNode.unfocus();
                          },
                          focusNode: _focusNode,
                          leading: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                            child: SvgPicture.asset(
                              IconSchemeButton.searchSVG,
                              colorFilter: ColorFilter.mode(
                                  theme.colorScheme.onSurface, BlendMode.srcIn),
                            ),
                          ),
                          hintText: lang.searchHint,
                          hintStyle: WidgetStateProperty.resolveWith<TextStyle>(
                              (state) => TextStyle(
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.5))),
                          backgroundColor:
                              WidgetStateProperty.resolveWith<Color>(
                                  (state) => theme.colorScheme.surfaceDim),
                        ),
                        SizedBox(height: 20 * delta),
                        /**
                         * Options
                         */
                        delta >= step
                            ? Opacity(
                                opacity: halfDelta,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        _onPressedSearchByBuilding(context);
                                      },
                                      child: Text(lang.searchBtn0),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        _onPressedSeeHistory(context);
                                      },
                                      child: Text(lang.searchBtn1),
                                    )
                                  ],
                                ),
                              )
                            : SizedBox(height: 0),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }
}
