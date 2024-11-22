import 'package:hive/hive.dart';
import 'package:room_track_flutterapp/types/local.dart';
part 'basicinfo_model.g.dart';

@HiveType(typeId: 1)
class BasicinfoModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  String type;

  @HiveField(2)
  String icon;

  BasicinfoModel({
    required this.name,
    required this.type,
    required this.icon,
  });

  factory BasicinfoModel.fromType(BasicInfoType t) {
    return BasicinfoModel(name: t.name, type: t.type, icon: t.icon);
  }
}
