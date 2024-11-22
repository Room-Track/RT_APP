import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_track_flutterapp/providers/favorites.dart';
import 'package:room_track_flutterapp/types/local.dart';

class CustomStar extends ConsumerStatefulWidget {
  final BasicInfoType basicInfo;
  const CustomStar({
    super.key,
    required this.basicInfo,
  });

  @override
  ConsumerState<CustomStar> createState() => _CustomStar();
}

class _CustomStar extends ConsumerState<CustomStar> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = FavoritesBox.indexOf(widget.basicInfo) != -1;
  }

  void _toggleFavorite() {
    _isFavorite = !_isFavorite;
    if (_isFavorite) {
      ref.read(favoritesProvider).requestAdd(widget.basicInfo);
    } else {
      ref.read(favoritesProvider).requestRemove(widget.basicInfo);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(5),
      onPressed: _toggleFavorite,
      icon: Icon(
        _isFavorite ? Icons.star_sharp : Icons.star_outline,
      ),
    );
  }
}
