

// post_button_widget.dart
import 'package:bennu_app/providers/user_media_providers.dart';
import 'package:bennu_app/widgets/postbuttonwidgets/button_style.dart';
import 'package:flutter/material.dart';

class PostButton extends StatelessWidget {
  const PostButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        style: CustomButtonStyle.greenRoundedButtonStyle(),
        onPressed: () async {
          await firestoreService.createPost(
            'ユーザーID',
            'ビデオのURL',
            'このビデオについての説明',
          );
        },
        child: const Text('Post'),
      ),
    );
  }
}
