
// post_button_widget.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:bennu_app/widgets/postbuttonwidgets/button_style.dart';

class PostButton extends ConsumerWidget {
  const PostButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postViewModel = ref.read(postViewModelProvider.notifier);

    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        style: CustomButtonStyle.greenRoundedButtonStyle(),
        onPressed: () async {
          // メディアのアップロードと投稿データの作成・保存を行う
          postViewModel.uploadMediaAndCaption;
        },
        child: const Text('Post'),
      ),
    );
  }
}