import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:room_track_flutterapp/models/basicinfo_model.dart';
import 'package:room_track_flutterapp/types/local.dart';

class HistoryBox {
  static final boxName = "History";
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
    final idx = HistoryBox.indexOf(data);
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

class HistoryNotifier extends ChangeNotifier {
  late Iterable<BasicInfoType> history;
  static const int maxSize = 10;

  HistoryNotifier({
    required this.history,
  });

  void requestRefresh() async {
    history = await HistoryBox.getAll();
    notifyListeners();
  }

  void pushHistory(BasicInfoType data) async {
    if (history.where((el) => el.name == data.name).isNotEmpty) {
      await HistoryBox.delOne(data);
    }
    if (history.length > maxSize) {
      return;
    }
    await HistoryBox.addOne(data);
    requestRefresh();
  }
}

final historyProvider = ChangeNotifierProvider<HistoryNotifier>(
  (ref) {
    return HistoryNotifier(history: []);
  },
);
