import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedTheme {
  static const List<String> properties = [
    'textSchemeName',
    'colorSchemeName',
    'languageCode',
  ];
  static const List<String> defaultValues = [
    'Medium',
    'System',
    'en',
  ];

  static Future<void> setDefaultIfAbsent() async {
    final shared = await SharedPreferences.getInstance();

    for (int i = 0; i < properties.length; i++) {
      final prop = properties.elementAt(i);
      final def = defaultValues.elementAt(i);
      if (!shared.containsKey(prop)) {
        shared.setString(prop, def);
      }
    }
  }

  static Future<void> changeValue(String key, String value) async {
    final shared = await SharedPreferences.getInstance();
    shared.setString(key, value);
  }

  static Future<Map<String, String>> getValues() async {
    final shared = await SharedPreferences.getInstance();
    Map<String, String> map = Map.fromEntries(
      properties.map((el) => MapEntry(el, shared.getString(el)!)),
    );
    return map;
  }
}

class ThemeNotifier extends ChangeNotifier {
  String textSchemeName;
  String colorSchemeName;
  String languageCode;

  ThemeNotifier({
    required this.textSchemeName,
    required this.colorSchemeName,
    required this.languageCode,
  });

  Future<void> initialize() async {
    await SharedTheme.setDefaultIfAbsent();
    Map<String, String> pref = await SharedTheme.getValues();
    textSchemeName = pref['textSchemeName']!;
    colorSchemeName = pref['colorSchemeName']!;
    languageCode = pref['languageCode']!;
    notifyListeners();
  }

  bool wasInitialized() {
    return textSchemeName.isNotEmpty &&
        colorSchemeName.isNotEmpty &&
        languageCode.isNotEmpty;
  }

  Future<void> changeColorSchemeName(String schemeName) async {
    colorSchemeName = schemeName;
    await SharedTheme.changeValue('colorSchemeName', colorSchemeName);
    notifyListeners();
  }

  Future<void> changeTextSchemeName(String schemeName) async {
    textSchemeName = schemeName;
    await SharedTheme.changeValue('textSchemeName', textSchemeName);
    notifyListeners();
  }

  Future<void> changeLanguageCode(String langCode) async {
    languageCode = langCode;
    await SharedTheme.changeValue('languageCode', languageCode);
    notifyListeners();
  }
}

final themeProvider = ChangeNotifierProvider<ThemeNotifier>((ref) {
  return ThemeNotifier(
    textSchemeName: "",
    colorSchemeName: "",
    languageCode: '',
  );
});
