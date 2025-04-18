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
    apiKey: 'AIzaSyDvo_ErfVDkGQzS-Lth0j8Fm3XgPx96css',
    appId: '1:770700444793:web:d3f90c0cc1510e2d5940a8',
    messagingSenderId: '770700444793',
    projectId: 'blazeon-eb4ec',
    authDomain: 'blazeon-eb4ec.firebaseapp.com',
    storageBucket: 'blazeon-eb4ec.firebasestorage.app',
    measurementId: 'G-738K6CJN23',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDE6UpKILLoLnmJin8TxESPG3yi8ZeLMMI',
    appId: '1:770700444793:android:97a4ad84c1eb16935940a8',
    messagingSenderId: '770700444793',
    projectId: 'blazeon-eb4ec',
    storageBucket: 'blazeon-eb4ec.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAl9zUh0yKuL1_hrucwx-XKeVCbh_AbJKI',
    appId: '1:770700444793:ios:3179da25ea4b2c175940a8',
    messagingSenderId: '770700444793',
    projectId: 'blazeon-eb4ec',
    storageBucket: 'blazeon-eb4ec.firebasestorage.app',
    iosBundleId: 'com.example.firesaftey',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAl9zUh0yKuL1_hrucwx-XKeVCbh_AbJKI',
    appId: '1:770700444793:ios:3179da25ea4b2c175940a8',
    messagingSenderId: '770700444793',
    projectId: 'blazeon-eb4ec',
    storageBucket: 'blazeon-eb4ec.firebasestorage.app',
    iosBundleId: 'com.example.firesaftey',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDvo_ErfVDkGQzS-Lth0j8Fm3XgPx96css',
    appId: '1:770700444793:web:144332c6c9d204fc5940a8',
    messagingSenderId: '770700444793',
    projectId: 'blazeon-eb4ec',
    authDomain: 'blazeon-eb4ec.firebaseapp.com',
    storageBucket: 'blazeon-eb4ec.firebasestorage.app',
    measurementId: 'G-JVRMNF4GFQ',
  );
}
