import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:room_track_flutterapp/env/env_variables.dart';
import 'package:room_track_flutterapp/types/interfaces.dart';
import 'package:room_track_flutterapp/types/local.dart';
import 'package:room_track_flutterapp/types/path.dart';

class AppFetch {
  static Future<Iterable<BasicInfoType>> basicInfoIterable(
      String byName) async {
    final String token =
        (await FirebaseAuth.instance.currentUser?.getIdToken())!;
    final url = Uri.https(EnvVariables.API_URL, '/interfaces/search', {
      'by': 'name',
      'name': byName,
    });
    final res = await http.get(url, headers: {
      'authorization': token,
    });
    if (200 <= res.statusCode && res.statusCode < 300) {
      final body = jsonDecode(res.body);
      final List raw = body['data'];
      return raw.map((json) {
        final iSearch = ISearch.fromJSON(json);
        return BasicInfoType.fromISearch(iSearch);
      });
    }
    return [];
  }

  static Future<Iterable<BasicInfoType>> basicInfoIterableFloor(
      int byLevel, String byRef) async {
    final String token =
        (await FirebaseAuth.instance.currentUser?.getIdToken())!;
    final url = Uri.https(EnvVariables.API_URL, '/interfaces/search', {
      'by': 'level',
      'level': byLevel.toString(),
      'ref': byRef,
    });
    final res = await http.get(url, headers: {
      'authorization': token,
    });
    if (200 <= res.statusCode && res.statusCode < 300) {
      final body = jsonDecode(res.body);
      final List raw = body['data'];
      return raw.map((json) {
        final iSearch = ISearch.fromJSON(json);
        return BasicInfoType.fromISearch(iSearch);
      });
    }
    return [];
  }

  static Future<Iterable<BasicInfoType>> basicInfoIterableType(
      String byType) async {
    final String token =
        (await FirebaseAuth.instance.currentUser?.getIdToken())!;
    final url = Uri.https(EnvVariables.API_URL, '/interfaces/search', {
      'by': 'type',
      'type': byType,
    });
    final res = await http.get(url, headers: {
      'authorization': token,
    });
    if (200 <= res.statusCode && res.statusCode < 300) {
      final body = jsonDecode(res.body);
      final List raw = body['data'];
      return raw.map((json) {
        final iSearch = ISearch.fromJSON(json);
        return BasicInfoType.fromISearch(iSearch);
      });
    }
    return [];
  }

  static Future<InfoPageType?> fullInfoPage(String name) async {
    final String token =
        (await FirebaseAuth.instance.currentUser?.getIdToken())!;
    final url = Uri.https(EnvVariables.API_URL, '/interfaces/info', {
      'by': 'name',
      'name': name,
    });
    final res = await http.get(url, headers: {
      'authorization': token,
    });
    if (200 <= res.statusCode && res.statusCode < 300) {
      final body = jsonDecode(res.body);
      final iInfo = IInfo.fromJSON(body['data']);
      return InfoPageType.fromType(iInfo);
    }
    return null;
  }

  static Future<Circle?> target(InfoPageType? general) async {
    if (general == null) return null;
    final String token =
        (await FirebaseAuth.instance.currentUser?.getIdToken())!;
    final url = Uri.https(EnvVariables.API_URL, '/models/location/one/', {
      'by': 'name',
      'name': general.name,
    });
    final res = await http.get(url, headers: {
      'authorization': token,
    });
    if (200 <= res.statusCode && res.statusCode < 300) {
      final body = jsonDecode(res.body);
      try {
        return Circle(
          circleId:
              CircleId("Target[${DateTime.now().millisecondsSinceEpoch}]"),
          center: LatLng(
            double.tryParse(body['data']['lat']) ?? 0,
            double.tryParse(body['data']['lng']) ?? 0,
          ),
          radius: double.tryParse(body['data']['rad']) ?? 0,
          fillColor: Colors.redAccent.shade100.withOpacity(0.3),
          strokeColor: Colors.redAccent.withOpacity(0.5),
          strokeWidth: 5,
        );
      } catch (err) {
        return null;
      }
    }
    return null;
  }

  static Future<PathData?> route(
      String lat, String lng, String alt, String target) async {
    final String token =
        (await FirebaseAuth.instance.currentUser?.getIdToken())!;
    final url = Uri.https(EnvVariables.API_URL, '/path/dijkstra/', {
      'lat': lat,
      'lng': lng,
      'alt': alt,
      'target': target,
    });
    final res = await http.get(url, headers: {
      'authorization': token,
    });
    if (200 <= res.statusCode && res.statusCode < 300) {
      final body = jsonDecode(res.body);
      final data = PathData.fromJSON(body['data']);
      return data;
    }
    return null;
  }

  static Future<String?> requestSingUpToken(
      String email, String password) async {
    final url = Uri.https(EnvVariables.API_URL, '/auth/signup');
    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'email': email,
          'password': password,
        },
      ),
    );
    if (200 <= res.statusCode && res.statusCode < 300) {
      final body = jsonDecode(res.body);
      return body['token'];
    }
    return null;
  }
}
