// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:room_track_flutterapp/env/env_variables.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static FirebaseOptions web = FirebaseOptions(
    apiKey: EnvVariables.WEB_API_KEY,
    appId: EnvVariables.WEB_APP_ID,
    messagingSenderId: EnvVariables.MESSAGING_ID,
    projectId: EnvVariables.PROJECT_ID,
    authDomain: EnvVariables.AUTH_DOM,
    storageBucket: EnvVariables.STORAGE_BUCKET,
    measurementId: EnvVariables.MEASUREMENT_ID,
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: EnvVariables.ANDROID_API_KEY,
    appId: EnvVariables.ANDROID_APP_ID,
    messagingSenderId: EnvVariables.MESSAGING_ID,
    projectId: EnvVariables.PROJECT_ID,
    storageBucket: EnvVariables.STORAGE_BUCKET,
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: EnvVariables.APPLE_API_KEY,
    appId: EnvVariables.APPLE_APP_ID,
    messagingSenderId: EnvVariables.MESSAGING_ID,
    projectId: EnvVariables.PROJECT_ID,
    storageBucket: EnvVariables.STORAGE_BUCKET,
    iosBundleId: EnvVariables.IOS_BUNDLE_ID,
  );

  static FirebaseOptions macos = FirebaseOptions(
    apiKey: EnvVariables.APPLE_API_KEY,
    appId: EnvVariables.APPLE_APP_ID,
    messagingSenderId: EnvVariables.MESSAGING_ID,
    projectId: EnvVariables.PROJECT_ID,
    storageBucket: EnvVariables.STORAGE_BUCKET,
    iosBundleId: EnvVariables.IOS_BUNDLE_ID,
  );

  static FirebaseOptions windows = FirebaseOptions(
    apiKey: EnvVariables.WINDOWS_API_KEY,
    appId: EnvVariables.WINDOWS_APP_ID,
    messagingSenderId: EnvVariables.MESSAGING_ID,
    projectId: EnvVariables.PROJECT_ID,
    authDomain: EnvVariables.AUTH_DOM,
    storageBucket: EnvVariables.STORAGE_BUCKET,
    measurementId: EnvVariables.MEASUREMENT_ID,
  );
}
