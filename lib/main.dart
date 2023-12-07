import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'firebase_options.dart';
import 'services/firebase_notification_service.dart';
import 'views/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async { // 非同期のメイン関数
  WidgetsFlutterBinding.ensureInitialized(); // Flutterエンジンとの接続を初期化
  await Firebase.initializeApp( // Firebaseを初期化
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey = 'YOUR_PUBLISHABLE_KEY'; // Stripeの公開可能なキーを設定
  Stripe.merchantIdentifier = 'your_apple_merchant_identifier'; // AppleのマーチャントIDを設定
  Stripe.urlScheme = 'your_url_scheme'; // URLスキームを設定
  await Stripe.instance.applySettings(); // Stripeの設定を適用
  FirebaseNotificationService firebaseNotificationService = FirebaseNotificationService(); // Firebase通知サービスを初期化
  await firebaseNotificationService.initialize(); // Firebase通知サービスを初期化
  await SharedPreferences.getInstance();

  runApp( // アプリケーションを起動
    const ProviderScope(child: MyApp()), // MyAppをルートウィジェットとして設定
  );
}

class MyApp extends StatelessWidget { // StatelessWidgetを継承したMyAppクラス
  const MyApp({super.key}); // コンストラクタ

  @override
  Widget build(BuildContext context) { // ビルドメソッド
    return MaterialApp( // MaterialAppウィジェットを返す
      title: 'bennu_app', // アプリケーションのタイトルを設定
      theme: ThemeData( // テーマデータを設定
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Color.fromARGB(255, 0, 26, 1), // BottomAppBarの色を設定
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 0, 26, 1), // AppBar
          titleTextStyle: TextStyle(color: Colors.white), // タイトルテキストスタイル
        ),
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 0, 26, 1), // 主要なウィジェット色を設定
          onPrimary: Colors.white, // 主要色の上のテキスト・アイコン色を設定
          surface: Color.fromARGB(255, 0, 26, 1), // カードやメニューの背景色を設定
          onSurface: Colors.white, // 表面色の上のテキスト・アイコン色を設定
        ),
        // FloatingActionButtonのテーマをカスタマイズします。
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 1, 0, 31), // FloatingActionButtonの背景色を設定
        ),
        // テキストのテーマをカスタマイズします。
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // 通常のテキストスタイルを設定
          bodyMedium: TextStyle(color: Colors.white), // 同上、少し小さいテキストのスタイルを設定
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.white, // 選択タブのラベルの色を設定
          unselectedLabelColor: Colors.grey, // 未選択タブのラベルの色を設定
        ),
        fontFamily: 'Roboto', // アプリ全体のフォントを設定
      ),
      home: MainPage(), // メインページをホームページとして設定
    );
  }
}
