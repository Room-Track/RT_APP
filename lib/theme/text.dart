import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextThemes {
  static String getName(AppLocalizations lang, int idx) {
    final namess = [
      lang.small,
      lang.med,
      lang.large,
      lang.xl,
    ];
    return namess[idx];
  }

  static const names = [
    'Small',
    'Medium',
    'Large',
    'Extra Large',
  ];
  static const _small = TextTheme(
    /**
   * Display
   */
    displayLarge: TextStyle(
      fontSize: 55.0,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 43.0,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      fontSize: 34.0,
      fontWeight: FontWeight.w400,
    ),
    /**
   * Headline
   */
    headlineLarge: TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w400,
    ),
    /**
   * Title
   */
    titleLarge: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
    ),
    /**
   * Body
   */
    bodyLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.w400,
    ),
    /**
   * Label
   */
    labelLarge: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      fontSize: 9.0,
      fontWeight: FontWeight.w500,
    ),
  );

  static const _medium = TextTheme(
    /**
   * Display
   */
    displayLarge: TextStyle(
      fontSize: 57.0,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 45.0,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      fontSize: 36.0,
      fontWeight: FontWeight.w400,
    ),
    /**
   * Headline
   */
    headlineLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w400,
    ),
    /**
   * Title
   */
    titleLarge: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    ),
    /**
   * Body
   */
    bodyLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
    ),
    /**
   * Label
   */
    labelLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
    ),
  );

  static const _large = TextTheme(
    /**
   * Display
   */
    displayLarge: TextStyle(
      fontSize: 59.0,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 47.0,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      fontSize: 38.0,
      fontWeight: FontWeight.w400,
    ),
    /**
   * Headline
   */
    headlineLarge: TextStyle(
      fontSize: 34.0,
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.w400,
    ),
    /**
   * Title
   */
    titleLarge: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    ),
    /**
   * Body
   */
    bodyLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    ),
    /**
   * Label
   */
    labelLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.w500,
    ),
  );

  static const _xl = TextTheme(
    /**
   * Display
   */
    displayLarge: TextStyle(
      fontSize: 61.0,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 49.0,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      fontSize: 40.0,
      fontWeight: FontWeight.w400,
    ),
    /**
   * Headline
   */
    headlineLarge: TextStyle(
      fontSize: 36.0,
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w400,
    ),
    /**
     * Title
     */
    titleLarge: TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    ),
    /**
     * Body
     */
    bodyLarge: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    ),
    /**
   * Label
   */
    labelLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      fontSize: 13.0,
      fontWeight: FontWeight.w500,
    ),
  );

  static TextTheme getScheme(String schemeName) {
    switch (schemeName) {
      case "Small":
        return _small;
      case "Medium":
        return _medium;
      case "Large":
        return _large;
      case "Extra Large":
        return _xl;
      default:
        return _medium;
    }
  }
}
