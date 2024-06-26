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
    apiKey: 'AIzaSyBgYztKqeV9F_8N8DCyAa0pC0Hbvm844F8',
    appId: '1:619987163186:web:6e32dfbd65d28b9d3c442b',
    messagingSenderId: '619987163186',
    projectId: 'authenticationtest-a1da5',
    authDomain: 'authenticationtest-a1da5.firebaseapp.com',
    storageBucket: 'authenticationtest-a1da5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAh-QdYEidSV2z6SHzGYmbICKDWVzkSuCU',
    appId: '1:619987163186:android:b96882766781bef63c442b',
    messagingSenderId: '619987163186',
    projectId: 'authenticationtest-a1da5',
    storageBucket: 'authenticationtest-a1da5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDoQwURDfC5SpfO84EyT3Ib8Y_W9aqzb1c',
    appId: '1:619987163186:ios:c4fcfa98b8c3f0ed3c442b',
    messagingSenderId: '619987163186',
    projectId: 'authenticationtest-a1da5',
    storageBucket: 'authenticationtest-a1da5.appspot.com',
    androidClientId: '619987163186-nhv5m4onpolon06sn21sl85qquf2nrp4.apps.googleusercontent.com',
    iosClientId: '619987163186-jaqss319rnocbbnpar3rn5kb9uf19md2.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialMediaApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDoQwURDfC5SpfO84EyT3Ib8Y_W9aqzb1c',
    appId: '1:619987163186:ios:a4ca528f8a4ad9c73c442b',
    messagingSenderId: '619987163186',
    projectId: 'authenticationtest-a1da5',
    storageBucket: 'authenticationtest-a1da5.appspot.com',
    androidClientId: '619987163186-nhv5m4onpolon06sn21sl85qquf2nrp4.apps.googleusercontent.com',
    iosClientId: '619987163186-bjnlgl35ikfm393gqmlt6l97li4d8vbr.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialMediaApp.RunnerTests',
  );
}
