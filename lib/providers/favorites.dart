import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:room_track_flutterapp/models/basicinfo_model.dart';
import 'package:room_track_flutterapp/types/local.dart';

class FavoritesBox {
  static final boxName = "Favorites";
  static late Box<BasicinfoModel> box;
  static Future<Box<BasicinfoModel>> get _box async =>
      await Hive.openBox<BasicinfoModel>(boxName);

  static Future<void> addOne(BasicInfoType data) async {
    box = await _box;
    final model = BasicinfoModel.fromType(data);
    await box.add(model);
  }

  static Future<void> delOne(BasicInfoType data) async {
    box = await _box;
    final idx = FavoritesBox.indexOf(data);
    await box.deleteAt(idx);
  }

  static Future<Iterable<BasicInfoType>> getAll() async {
    box = await _box;
    return box.values.map((model) => BasicInfoType.fromModel(model));
  }

  static int indexOf(BasicInfoType data) {
    final values = box.values.toList();
    return values.indexWhere((model) => model.name == data.name);
  }
}

class FavoritesNotifier extends ChangeNotifier {
  Future<Iterable<BasicInfoType>> favorites;

  FavoritesNotifier({
    required this.favorites,
  });

  void requestRefresh() async {
    favorites = FavoritesBox.getAll();
    notifyListeners();
  }

  void requestRemove(BasicInfoType data) async {
    await FavoritesBox.delOne(data);
    requestRefresh();
  }

  void requestAdd(BasicInfoType data) async {
    await FavoritesBox.addOne(data);
    requestRefresh();
  }
}

final favoritesProvider = ChangeNotifierProvider<FavoritesNotifier>((ref) {
  return FavoritesNotifier(favorites: FavoritesBox.getAll());
});
