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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9Tyq9NEINIRm3TRTXfapI8L8m6QYCz9U',
    appId: '1:60571600002:android:2216e54f43156c9176609b',
    messagingSenderId: '60571600002',
    projectId: 'social-app-8ca4f',
    storageBucket: 'social-app-8ca4f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA-FuV6_DCZvCeRbNe3AlxEOC90P5tp5Og',
    appId: '1:60571600002:ios:cb02c68d1df9428976609b',
    messagingSenderId: '60571600002',
    projectId: 'social-app-8ca4f',
    storageBucket: 'social-app-8ca4f.appspot.com',
    androidClientId: '60571600002-es9qicpm86qb8r946a94fhjftvitiq0h.apps.googleusercontent.com',
    iosClientId: '60571600002-qbuh3iccqafb8b761n5e2upnqe9nldts.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialApp',
  );
}