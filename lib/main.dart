

// main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'views/homepages/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutterバインディングの初期化
  await Firebase.initializeApp(); // Firebaseの初期化
  Stripe.publishableKey = 'YOUR_PUBLISHABLE_KEY'; // Stripeの公開可能キーの設定
  runApp(const MyApp()); // アプリケーションを実行
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'bennu_app',
      theme: ThemeData(
        // アプリの基本的な色スキームをカスタマイズします。
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 0, 26, 1), // 主要なウィジェット色
          onPrimary: Colors.white, // 主要色の上のテキスト・アイコン色
          surface: Color.fromARGB(255, 0, 26, 1), // カードやメニューの背景色
          onSurface: Colors.white, // 表面色の上のテキスト・アイコン色
        ),
        // AppBarのテーマをカスタマイズします。
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 0, 26, 1),
          titleTextStyle: TextStyle(color: Colors.white),
        ),
        // FloatingActionButtonのテーマをカスタマイズします。
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 1, 0, 31),
        ),
        // テキストのテーマをカスタマイズします。
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // 通常のテキストスタイル
          bodyMedium: TextStyle(color: Colors.white), // 同上、少し小さいテキスト
          // その他のテキストスタイルも同様にカスタマイズできます。
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.white, // 選択されたタブのラベルの色
          unselectedLabelColor: Colors.grey, // 選択されていないタブのラベルの色
        ),
        // アプリ全体のフォントをRobotoに設定します。
        fontFamily: 'Roboto',
      ),
      home: HomeView(), // HomeViewウィジェットをホームページとして使用します。
    );
  }
}
