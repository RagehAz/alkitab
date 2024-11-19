// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBzJO2inXIf0CUKWUBf7dYHZmbuODTAW4w',
    appId: '1:526431452328:web:57fb4bd0a8f6310d58169d',
    messagingSenderId: '526431452328',
    projectId: 'al-kitab-1a13b',
    authDomain: 'al-kitab-1a13b.firebaseapp.com',
    storageBucket: 'al-kitab-1a13b.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA8Tn5jVdZt-7qZ2D3fi-TZX3XwjU7JhfE',
    appId: '1:526431452328:android:284a9f7448cae30858169d',
    messagingSenderId: '526431452328',
    projectId: 'al-kitab-1a13b',
    storageBucket: 'al-kitab-1a13b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDk2LokHiggM2i1m8SxIDQ_xoD-UgMus-g',
    appId: '1:526431452328:ios:f8df3dd86914f54a58169d',
    messagingSenderId: '526431452328',
    projectId: 'al-kitab-1a13b',
    storageBucket: 'al-kitab-1a13b.firebasestorage.app',
    androidClientId: '526431452328-omj612uaq5blvg0scuqm18aelqag055b.apps.googleusercontent.com',
    iosClientId: '526431452328-b493sgjqgos411urk7v0lt4qs7v4lltt.apps.googleusercontent.com',
    iosBundleId: 'net.bldrs.alkitab',
  );
}
