

// edit_profile_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/profile_viewmodel.dart';

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
                  // ユーザー名を編集するテキストフィールド
                  TextField(
                    controller: usernameController,
                    onChanged: viewModel.updateUsername,
                    decoration: const InputDecoration(labelText: "Username"),
                  ),
                  // プロフィールの変更を保存するためのボタン
                  ElevatedButton(
                    onPressed: () async {
                      // プロフィールの変更を保存
                      await viewModel.saveProfileChanges();
                      // 現在の画面を閉じる
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
