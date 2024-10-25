// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions]
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
    apiKey: 'AIzaSyC3OvCRfPwoH0DhtozXebPIC2fS9-cpBlA',
    appId: '1:713212663037:web:7b1d2ba547540671831a94',
    messagingSenderId: '713212663037',
    projectId: 'healtalk-8649e',
    authDomain: 'healtalk-8649e.firebaseapp.com',
    storageBucket: 'healtalk-8649e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC3OvCRfPwoH0DhtozXebPIC2fS9-cpBlA',
    appId: '1:713212663037:android:dc8c3d0f411e0994831a94',
    messagingSenderId: '713212663037',
    projectId: 'healtalk-8649e',
    storageBucket: 'healtalk-8649e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC841R5M3s6aE1etE81R4ZyapotEL6cAEI',
    appId: '1:713212663037:ios:3448d22b372c8d7b831a94',
    messagingSenderId: '713212663037',
    projectId: 'healtalk-8649e',
    storageBucket: 'healtalk-8649e.appspot.com',
    iosBundleId: 'com.example.healTalk',
  );

}