

// usericon_button_widget.dart
import 'package:flutter/material.dart';

class UserIconWidget extends StatelessWidget {
  final String userProfileUrl; // ユーザーのプロフィール画像のURL
  final VoidCallback onFollow; // フォローボタンのコールバック
  final VoidCallback onProfileTap; // プロフィールタップのコールバック

  const UserIconWidget({
    Key? key,
    required this.userProfileUrl,
    required this.onFollow,
    required this.onProfileTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        GestureDetector(
          onTap: onProfileTap,
          child: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(userProfileUrl),
          ),
        ),
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
