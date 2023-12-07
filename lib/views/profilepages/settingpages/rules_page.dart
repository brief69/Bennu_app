import 'package:flutter/material.dart';

// ルールページのステートレスウィジェット
class RulesPage extends StatelessWidget {
  const RulesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Bennu Rules', style: theme.textTheme.titleLarge),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Container(
        color: theme.primaryColor,
        child: ListView(
          children: const [
            ListTile(
              title: Text(
                '1. 正直に取引しましょう。',
                style: TextStyle(color: Colors.white), // テキスト色を白に設定
              ),
            ),
            ListTile(
              title: Text(
                '2. ステマや嘘は、コメントに書く。',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              title: Text(
                '3. コメントのバッドボタンは、コメントがステマや嘘と判断した時に押す。',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              title: Text(
                '4. すべての商品を定価の半額で出品する。',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
