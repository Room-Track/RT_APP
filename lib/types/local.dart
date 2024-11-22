import 'package:room_track_flutterapp/models/basicinfo_model.dart';
import 'package:room_track_flutterapp/types/interfaces.dart';

class BasicInfoType {
  final String name;
  final String type;
  final String icon;

  BasicInfoType({
    required this.name,
    required this.type,
    required this.icon,
  });

  factory BasicInfoType.fromISearch(ISearch iSearch) {
    return BasicInfoType(
      name: iSearch.name,
      type: iSearch.type,
      icon: "assets/card/${iSearch.type.toLowerCase()}.svg",
    );
  }

  factory BasicInfoType.fromJSON(Map<String, dynamic> json) {
    return BasicInfoType(
        name: json['name'], type: json['type'], icon: json['icon']);
  }

  factory BasicInfoType.fromModel(BasicinfoModel model) {
    return BasicInfoType(name: model.name, type: model.type, icon: model.icon);
  }

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'type': type,
      'icon': icon,
    };
  }

  @override
  String toString() {
    return "BasicInfoType: $name $type $icon";
  }
}

class InfoPageType {
  final String name;
  final String type;
  final String icon;
  final int level;
  final ILoc? loc;
  final IRef? ref;

  InfoPageType({
    required this.name,
    required this.type,
    required this.icon,
    required this.level,
    required this.loc,
    required this.ref,
  });

  @override
  String toString() {
    return "InfoPageType: $name $type $level $ref";
  }

  factory InfoPageType.fromType(IInfo iInfo) {
    return InfoPageType(
      name: iInfo.name,
      type: iInfo.type,
      icon: "assets/card/${iInfo.type.toLowerCase()}.svg",
      level: iInfo.level,
      loc: iInfo.loc,
      ref: iInfo.ref,
    );
  }
}

class MapPageType {
  IUserPos userPos;
  List<IIndication> indications;

  MapPageType({
    required this.userPos,
    required this.indications,
  });

  @override
  String toString() {
    return "MapPageType";
  }
}
