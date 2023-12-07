import 'package:flutter/material.dart';

// 住所設定ページのウィジェットを定義
class AddressSetPage extends StatefulWidget {
  const AddressSetPage({super.key});

  // _AddressSetPageStateを作成
  @override
  // ignore: library_private_types_in_public_api
  _AddressSetPageState createState() => _AddressSetPageState();
}

// AddressSetPageの状態を管理するクラス
class _AddressSetPageState extends State<AddressSetPage> {
  // フォームのキーを定義
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // 住所を保存するための変数
  String address = '';
  // 保存された住所を表示するための変数
  String savedAddress = 'No Address Saved';

  // ウィジェットのビルドメソッド
  @override
  Widget build(BuildContext context) {
    // テーマを取得
    final theme = Theme.of(context);
    // Scaffoldを返す
    return Scaffold(
      // AppBarを設定
      appBar: AppBar(
        // タイトルを設定
        title: Text('Address', style: theme.textTheme.titleLarge),
        // AppBarの背景色を設定
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      // 背景色を設定
      backgroundColor: theme.colorScheme.background,
      // bodyを設定
      body: Padding(
        // Paddingを設定
        padding: const EdgeInsets.all(16.0),
        // Formを設定
        child: Form(
          // Formのキーを設定
          key: _formKey,
          // Columnを設定
          child: Column(
            // Columnの子ウィジェットを設定
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // テキストを設定
              const Text(
                'Register your address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              // TextFormFieldを設定
              TextFormField(
                // デコレーションを設定
                decoration: const InputDecoration(
                  labelText: 'Address',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                // バリデーションを設定
                validator: (value) => value!.isEmpty ? 'Address is required' : null,
                // 保存時の処理を設定
                onSaved: (value) => address = value!,
                // 入力文字色を設定
                style: const TextStyle(color: Colors.black),
              ),
              // ElevatedButtonを設定
              ElevatedButton(
                // ボタン押下時の処理を設定
                onPressed: () {
                  // バリデーションを実行
                  if (_formKey.currentState!.validate()) {
                    // 保存処理を実行
                    _formKey.currentState!.save();
                    // 状態を更新
                    setState(() {
                      savedAddress = address;
                    });
                  }
                },
                // ボタンのテキストを設定
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              // SizedBoxを設定
              const SizedBox(height: 20),
              // テキストを設定
              const Text(
                'Registered Address:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              // 保存された住所を表示
              Text(
                savedAddress,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
