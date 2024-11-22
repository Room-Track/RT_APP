class ISearch {
  final String name;
  final String type;

  ISearch({
    required this.name,
    required this.type,
  });

  factory ISearch.fromJSON(Map<String, dynamic> json) {
    return ISearch(name: json['name'], type: json['type']);
  }

  @override
  String toString() {
    return "ISearch: $name $type";
  }
}

class IRef {
  final String name;
  final int lowestF;
  final int highestF;
  final bool inside;
  final String lat;
  final String lng;

  IRef({
    required this.name,
    required this.lowestF,
    required this.highestF,
    required this.inside,
    required this.lat,
    required this.lng,
  });

  factory IRef.fromJSON(Map<String, dynamic> json) {
    return IRef(
        name: json['name'],
        lowestF: json['lowestF'],
        highestF: json['highestF'],
        inside: json['inside'],
        lat: json['lat'],
        lng: json['lng']);
  }
}

class ILoc {
  final double lat;
  final double lng;
  final double alt;
  ILoc(this.lat, this.lng, this.alt);
  factory ILoc.fromJSON(Map<String, dynamic> json) {
    return ILoc(double.tryParse(json['lat']) ?? 0,
        double.tryParse(json['lng']) ?? 0, double.tryParse(json['alt']) ?? 0);
  }
}

class IInfo {
  final String name;
  final String type;
  final int level;
  final ILoc? loc;
  final IRef? ref;

  IInfo({
    required this.name,
    required this.type,
    required this.level,
    required this.loc,
    required this.ref,
  });

  factory IInfo.fromJSON(Map<String, dynamic> json) {
    return IInfo(
      name: json['name'],
      type: json['type'],
      level: json['level'],
      loc: json['loc'] != null ? ILoc.fromJSON(json['loc']) : null,
      ref: json['ref'] == null ? null : IRef.fromJSON(json['ref']),
    );
  }
}

class IIndication {
  final String name;
  final String img;
  final String forwardInfo;
  final String backwardInfo;
  final String lat;
  final String lng;
  final String rad;

  IIndication({
    required this.name,
    required this.img,
    required this.forwardInfo,
    required this.backwardInfo,
    required this.lat,
    required this.lng,
    required this.rad,
  });

  factory IIndication.fromJSON(Map<String, dynamic> json) {
    return IIndication(
        name: json['name'],
        img: json['img'],
        forwardInfo: json['forwardInfo'],
        backwardInfo: json['backwardInfo'],
        lat: json['lat'],
        lng: json['lng'],
        rad: json['rad']);
  }
}

class IUserPos {
  double lat;
  double lng;

  IUserPos({
    required this.lat,
    required this.lng,
  });

  factory IUserPos.fromJSON(Map<String, dynamic> json) {
    return IUserPos(lat: json['lat'], lng: json['lng']);
  }
}
