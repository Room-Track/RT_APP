class PathNode {
  final String name;
  final double lat;
  final double lng;
  final double alt;
  final double rad;

  PathNode({
    required this.name,
    required this.lat,
    required this.lng,
    required this.alt,
    required this.rad,
  });

  @override
  String toString() {
    return '$name / $lat - $lng - $alt / $rad';
  }

  factory PathNode.fromJSON(Map<String, dynamic> json) {
    return PathNode(
      name: json['name'],
      lat: double.tryParse(json['latitude']) ?? 0,
      lng: double.tryParse(json['longitude']) ?? 0,
      alt: double.tryParse(json['altitude']) ?? 0,
      rad: double.tryParse(json['rad']) ?? 0,
    );
  }
}

class PathRoute {
  final String from;
  final String to;
  final String info;

  PathRoute({
    required this.from,
    required this.to,
    required this.info,
  });

  factory PathRoute.fromJSON(Map<String, dynamic> json) {
    return PathRoute(
      from: json['from'],
      to: json['to'],
      info: json['info'],
    );
  }
}

class PathData {
  final List<String> path;
  final Map<String, PathNode> nodes;
  final List<PathRoute> route;
  final List<List<List<double>>> polylines;

  PathData({
    required this.path,
    required this.nodes,
    required this.route,
    required this.polylines,
  });

  factory PathData.fromJSON(Map<String, dynamic> json) {
    final polylines = (json['polylines'] as List<dynamic>).map((el) {
      return (el as List<dynamic>).map((el2) {
        return (el2 as List<dynamic>).map((str) {
          return double.tryParse(str) ?? 0;
        }).toList();
      }).toList();
    }).toList();

    final route = (json['route'] as List<dynamic>).map((el) {
      return PathRoute.fromJSON(el);
    }).toList();

    final nodes = (json['nodes'] as Map<String, dynamic>).map((key, value) {
      final node = PathNode.fromJSON(value as Map<String, dynamic>);
      return MapEntry(key, node);
    });

    return PathData(
      path: (json['path'] as List<dynamic>).map((el) => el.toString()).toList(),
      nodes: nodes,
      route: route,
      polylines: polylines,
    );
  }
}
