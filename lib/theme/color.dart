// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ColorThemes {
  static String getName(AppLocalizations lang, int idx) {
    final namess = [
      lang.light,
      lang.dark,
      lang.system,
    ];
    return namess[idx];
  }

  static const names = [
    'Light',
    'Dark',
    'System',
  ];

  static const Color _black = Color(0xff161616);
  static const Color _white = Color(0xfffdfdfd);

  static const Color _lightBlue = Color(0xff80d6ff);
  static const Color _lightBlueOp = Color.fromARGB(100, 128, 215, 255);
  static const Color _brightBlue = Color(0xff007aff);
  static const Color _darkBlue = Color(0xff0079b2);
  static const Color _darkBlueOp = Color.fromARGB(164, 0, 122, 178);

  static const Color _darkGrey = Color(0xff252525);
  static const Color _grey = Color(0xff666666);
  static const Color _lightGrey = Color.fromARGB(255, 218, 218, 218);
  static const Color _red = Color(0xfff04235);

  static const _darkTheme = ColorScheme(
    brightness: Brightness.dark,
    primary: _brightBlue,
    onPrimary: _white,
    secondary: _lightBlueOp,
    onSecondary: _white,
    error: _red,
    onError: _white,
    surface: _black,
    onSurface: _white,
    surfaceBright: _grey,
    surfaceDim: _darkGrey,
  );

  static const _ligthTheme = ColorScheme(
    brightness: Brightness.light,
    primary: _brightBlue,
    onPrimary: _black,
    secondary: _darkBlueOp,
    onSecondary: _black,
    error: _red,
    onError: _black,
    surface: _white,
    onSurface: _black,
    surfaceBright: _grey,
    surfaceDim: _lightGrey,
  );

  static ColorScheme getScheme(String schemeName, BuildContext context) {
    switch (schemeName) {
      case 'Dark':
        return _darkTheme;
      case 'Light':
        return _ligthTheme;
      default:
        return MediaQuery.of(context).platformBrightness == Brightness.light
            ? _ligthTheme
            : _darkTheme;
    }
  }
}
