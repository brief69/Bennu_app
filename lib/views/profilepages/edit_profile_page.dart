import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/viewmodels/profile_viewmodel.dart';

class EditProfilePage extends StatelessWidget {
  // コンストラクタ
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // ProfileViewModelのインスタンスを作成
      create: (_) => ProfileViewModel(),
      child: Consumer<ProfileViewModel>(
        // ProfileViewModelを使用してUIを構築
        builder: (_, viewModel, __) {
          // ユーザー名を編集するためのTextEditingControllerを作成
          final TextEditingController usernameController = TextEditingController(text: viewModel.profile?.name ?? '');

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 15), // ユーザー名を編集するテキストフィールドの位置を下に移動
                  // ユーザー名を編集するテキストフィールド
                  TextField(
                    controller: usernameController,
                    onChanged: viewModel.updateUsername,
                    decoration: const InputDecoration(labelText: "Username"),
                  ),
                  // プロフィールの変更を保存するためのボタン
                  ElevatedButton(
                    onPressed: () async {
                      // 現在の画面のBuildContextを保存
                      BuildContext currentContext = context;
                      // プロフィールの変更を保存
                      await viewModel.saveProfileChanges().then((_) {
                      // 現在の画面を閉じる
                      Navigator.of(currentContext).pop();
                      });
                    },
                    child: const Text("OK", style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
