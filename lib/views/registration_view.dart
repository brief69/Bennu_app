import 'package:bennu/viewmodels/registration_viewmodel.dart';
import 'package:flutter/material.dart';

// ユーザー登録画面を表示するためのウィジェット
class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  // 状態を管理するためのStateオブジェクトを生成
  RegistrationViewState createState() => RegistrationViewState();
}

// ユーザー登録画面の状態を管理するクラス
class RegistrationViewState extends State<RegistrationView> {
  // メールアドレス入力用のコントローラ
  final _emailController = TextEditingController();
  // ユーザー登録とウォレット作成のロジックを管理するViewModel
  final _viewModel = RegistrationViewModel();

  @override
  // 画面のビルドメソッド
  Widget build(BuildContext context) {
    // テーマデータの取得
    final theme = Theme.of(context);
    // Scaffoldウィジェットで画面を構成
    return Scaffold(
      // アプリバーの設定
      appBar: AppBar(
        title: Text('SignUp', style: theme.textTheme.titleLarge),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      // 本体部分の設定
      body: Column(
          children: [
          // メールアドレス入力フィールド
          TextField(controller: _emailController),
          // 登録ボタン
          ElevatedButton(
            onPressed: () {
              // ボタン押下時にViewModelの登録メソッドを呼び出し
              _viewModel.registerAndCreateWallet(_emailController.text);
            },
            child: const Text('Sign up!'),
          ),
        ],
      ),
    );
  }
}
