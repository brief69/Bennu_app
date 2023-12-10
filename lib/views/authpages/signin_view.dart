import 'package:flutter/material.dart';

// サインイン画面を表示するためのウィジェット
class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('SignIn', style: theme.textTheme.titleLarge),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Column(
        children: [
          // メールアドレス入力フィールド
          const TextField(
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
          // パスワード入力フィールド
          const TextField(
            decoration: InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
          ),
          // サインインボタン
          ElevatedButton(
            onPressed: () {
              // サインインロジックをここに記述
            },
            child: const Text('Sign in'),
          ),
        ],
      ),
    );
  }
}
