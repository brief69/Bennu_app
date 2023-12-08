import 'package:flutter/material.dart';

// UserIconWidgetは、ユーザーのプロフィール画像とフォローボタンを表示するウィジェットです。
class UserIconWidget extends StatelessWidget {
  final String userProfileUrl; // ユーザーのプロフィール画像のURL
  final VoidCallback onFollow; // フォローボタンが押されたときのコールバック
  final VoidCallback onProfileTap; // プロフィール画像がタップされたときのコールバック

  // コンストラクタ。ユーザーのプロフィール画像のURL、フォローボタンのコールバック、プロフィール画像のタップコールバックを必須パラメータとして受け取ります。
  const UserIconWidget({
    Key? key,
    required this.userProfileUrl,
    required this.onFollow,
    required this.onProfileTap,
  }) : super(key: key);

  // ウィジェットを描画します。
  @override
  Widget build(BuildContext context) {
    // ユーザーのプロフィール画像とフォローボタンを含むスタックを返します。
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // プロフィール画像を表示します。タップすると、onProfileTapコールバックが呼び出されます。
        GestureDetector(
          onTap: onProfileTap,
          child: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(userProfileUrl),
          ),
        ),
        // フォローボタンを表示します。タップすると、onFollowコールバックが呼び出されます。
        Positioned(
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: onFollow,
            child: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                size: 20.0,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
