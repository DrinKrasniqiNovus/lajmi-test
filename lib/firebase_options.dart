
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


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
    apiKey: 'AIzaSyD_NVIwux13lD_XcMMcIHwlvUJwmXy-tCk',
    appId: '1:373071559569:web:c5de30bee0105b61a53830',
    messagingSenderId: '373071559569',
    projectId: 'app-lajmi',
    authDomain: 'app-lajmi.firebaseapp.com',
    storageBucket: 'app-lajmi.appspot.com',
    measurementId: 'G-3BFDFL0F90',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCpv8GSwP7EcZi4RXhgUI2--furalxMExk',
    appId: '1:373071559569:android:de697286fed83a76a53830',
    messagingSenderId: '373071559569',
    projectId: 'app-lajmi',
    storageBucket: 'app-lajmi.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCH6TaNnzY6MJ0I0806KD0Cag3zUWJ2mvk',
    appId: '1:373071559569:ios:79aa24537b67e634a53830',
    messagingSenderId: '373071559569',
    projectId: 'app-lajmi',
    storageBucket: 'app-lajmi.appspot.com',
    androidClientId: '373071559569-6ro98jc2gp2rl59t07h4t8q6pea6onnc.apps.googleusercontent.com',
    iosClientId: '373071559569-j26ju76kmv1vdlgntm4pod2lp3q1p6vj.apps.googleusercontent.com',
    iosBundleId: 'com.example.lajmiNet',
  );
}
