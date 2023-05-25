// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyDWVAkGiz3O34zRMAgk6Cmpi2ZyYQciRfM',
    appId: '1:556055822011:web:cf896cb5324ef39fc6b39e',
    messagingSenderId: '556055822011',
    projectId: 'flutterauth-9f7c9',
    authDomain: 'flutterauth-9f7c9.firebaseapp.com',
    storageBucket: 'flutterauth-9f7c9.appspot.com',
    measurementId: 'G-LK59HT6XCE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAeWdGsy2zBFJ4Armqn4P2BkhdvMnVLGkU',
    appId: '1:556055822011:android:5e77eb4b227b89d0c6b39e',
    messagingSenderId: '556055822011',
    projectId: 'flutterauth-9f7c9',
    storageBucket: 'flutterauth-9f7c9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB75b2E6Cy8a77jfbGov1fFfsImNTiCj20',
    appId: '1:556055822011:ios:b694baef48be5afdc6b39e',
    messagingSenderId: '556055822011',
    projectId: 'flutterauth-9f7c9',
    storageBucket: 'flutterauth-9f7c9.appspot.com',
    iosClientId: '556055822011-6238obnaaq0nl5n4mce5132cfpfemnta.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterProjectApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB75b2E6Cy8a77jfbGov1fFfsImNTiCj20',
    appId: '1:556055822011:ios:b694baef48be5afdc6b39e',
    messagingSenderId: '556055822011',
    projectId: 'flutterauth-9f7c9',
    storageBucket: 'flutterauth-9f7c9.appspot.com',
    iosClientId: '556055822011-6238obnaaq0nl5n4mce5132cfpfemnta.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterProjectApp',
  );
}
