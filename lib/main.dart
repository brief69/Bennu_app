

// main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'firebase_options.dart';
import 'services/firebase_notification_service.dart';
import 'views/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey = 'YOUR_PUBLISHABLE_KEY';
  Stripe.merchantIdentifier = 'your_apple_merchant_identifier';
  Stripe.urlScheme = 'your_url_scheme';
  await Stripe.instance.applySettings();
  FirebaseNotificationService firebaseNotificationService = FirebaseNotificationService();
  await firebaseNotificationService.initialize();

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'bennu_app',
      theme: ThemeData(
        // Basic color scheme of the app
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 0, 26, 1), // 主要なウィジェット色
          onPrimary: Colors.white, // 主要色の上のテキスト・アイコン色
          surface: Color.fromARGB(255, 0, 26, 1), // カードやメニューの背景色
          onSurface: Colors.white, // 表面色の上のテキスト・アイコン色
        ),
        // AppBar Theme Customization
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
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.white, // 選択タブのラベルの色
          unselectedLabelColor: Colors.grey, // 未選択タブのラベルの色
        ),
        fontFamily: 'Roboto', // アプリ全体のフォント
      ),
      home: MainPage(),
    );
  }
}
