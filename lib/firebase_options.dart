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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD_LoxEhzreaUJlwVREb3MjIvJOdPsFxqU',
    appId: '1:649275803873:web:2ce16fbd406aa5f5568fa0',
    messagingSenderId: '649275803873',
    projectId: 'fir-testing-cd18a',
    authDomain: 'fir-testing-cd18a.firebaseapp.com',
    storageBucket: 'fir-testing-cd18a.firebasestorage.app',
    measurementId: 'G-1ZSEMW105Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD1iZZ6i2TAY3sAsK8ruHI2KooPDD2sXyE',
    appId: '1:649275803873:android:873cfec42c9095ff568fa0',
    messagingSenderId: '649275803873',
    projectId: 'fir-testing-cd18a',
    storageBucket: 'fir-testing-cd18a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDpFI31MMNLgrgKPH1-AzH98McAaHkjWk0',
    appId: '1:649275803873:ios:a96fa78759595fbf568fa0',
    messagingSenderId: '649275803873',
    projectId: 'fir-testing-cd18a',
    storageBucket: 'fir-testing-cd18a.firebasestorage.app',
    iosBundleId: 'com.example.firebasetesting',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDpFI31MMNLgrgKPH1-AzH98McAaHkjWk0',
    appId: '1:649275803873:ios:a96fa78759595fbf568fa0',
    messagingSenderId: '649275803873',
    projectId: 'fir-testing-cd18a',
    storageBucket: 'fir-testing-cd18a.firebasestorage.app',
    iosBundleId: 'com.example.firebasetesting',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD_LoxEhzreaUJlwVREb3MjIvJOdPsFxqU',
    appId: '1:649275803873:web:5b059c30e3b0895d568fa0',
    messagingSenderId: '649275803873',
    projectId: 'fir-testing-cd18a',
    authDomain: 'fir-testing-cd18a.firebaseapp.com',
    storageBucket: 'fir-testing-cd18a.firebasestorage.app',
    measurementId: 'G-PP36TDJ2CB',
  );
}
