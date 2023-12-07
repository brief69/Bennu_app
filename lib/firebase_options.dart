// FlutterFire CLIによって生成されたファイル。
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Firebaseアプリで使用するデフォルトの[FirebaseOptions]。
///
/// 例：
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
          'DefaultFirebaseOptionsはmacosに対して設定されていません - '
          'FlutterFire CLIを再度実行することで再設定できます。',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptionsはwindowsに対して設定されていません - '
          'FlutterFire CLIを再度実行することで再設定できます。',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptionsはlinuxに対して設定されていません - '
          'FlutterFire CLIを再度実行することで再設定できます。',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptionsはこのプラットフォームをサポートしていません。',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAgC1FXuc7EaFDSIz7-VYlx9m4KJvkbgAg',
    appId: '1:375417052674:web:9862cef2128e0d7622511b',
    messagingSenderId: '375417052674',
    projectId: 'bennu-c2cb5',
    authDomain: 'bennu-c2cb5.firebaseapp.com',
    storageBucket: 'bennu-c2cb5.appspot.com',
    measurementId: 'G-PZNWBV3YW4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7hM1PIswo_-PmxsLyDMNNXuwaPDBelf4',
    appId: '1:375417052674:android:44b0358ddc2250b222511b',
    messagingSenderId: '375417052674',
    projectId: 'bennu-c2cb5',
    storageBucket: 'bennu-c2cb5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCTxNKRgqBA79zgK2GUIRsRtF-UdRTRPOU',
    appId: '1:375417052674:ios:a44a1323c0591a3b22511b',
    messagingSenderId: '375417052674',
    projectId: 'bennu-c2cb5',
    storageBucket: 'bennu-c2cb5.appspot.com',
    iosClientId: '375417052674-9910adru93nrmtlcpp81na4rgboeg1tc.apps.googleusercontent.com',
    iosBundleId: 'com.example.dms',
  );
}
