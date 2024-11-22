// ignore_for_file: non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvVariables {
  static String API_URL = dotenv.env['API_URL'] ?? 'API_URL_NOT_FOUND';
  static String AUTH_DOM = dotenv.env['AUTH_DOM'] ?? 'NOT_FOUND_AUTH_DOM';
  static String MESSAGING_ID =
      dotenv.env['MESSAGING_ID'] ?? 'NOT_FOUND_MESSAGING_ID';
  static String STORAGE_BUCKET =
      dotenv.env['STORAGE_BUCKET'] ?? 'NOT_FOUND_STORAGE_BUCKET';
  static String MEASUREMENT_ID =
      dotenv.env['MEASUREMENT_ID'] ?? 'NOT_FOUND_MEASUREMENT_ID';
  static String PROJECT_ID = dotenv.env['PROJECT_ID'] ?? 'NOT_FOUND_PROJECT_ID';
  static String WEB_API_KEY =
      dotenv.env['WEB_API_KEY'] ?? 'NOT_FOUND_WEB_API_KEY';
  static String WEB_APP_ID = dotenv.env['WEB_APP_ID'] ?? 'NOT_FOUND_WEB_APP_ID';
  static String ANDROID_API_KEY =
      dotenv.env['ANDROID_API_KEY'] ?? 'NOT_FOUND_ANDROID_API_KEY';
  static String ANDROID_APP_ID =
      dotenv.env['ANDROID_APP_ID'] ?? 'NOT_FOUND_ANDROID_APP_ID';
  static String APPLE_API_KEY =
      dotenv.env['APPLE_API_KEY'] ?? 'NOT_FOUND_APPLE_API_KEY';
  static String APPLE_APP_ID =
      dotenv.env['APPLE_APP_ID'] ?? 'NOT_FOUND_APPLE_APP_ID';
  static String IOS_BUNDLE_ID =
      dotenv.env['IOS_BUNDLE_ID'] ?? 'NOT_FOUND_IOS_BUNDLE_ID';
  static String WINDOWS_API_KEY =
      dotenv.env['WINDOWS_API_KEY'] ?? 'NOT_FOUND_WINDOWS_API_KEY';
  static String WINDOWS_APP_ID =
      dotenv.env['WINDOWS_APP_ID'] ?? 'NOT_FOUND_WINDOWS_APP_ID';
}
