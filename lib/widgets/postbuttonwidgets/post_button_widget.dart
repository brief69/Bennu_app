
// post_button_widget.dart
import 'package:bennu/viewmodels/post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:bennu/widgets/postbuttonwidgets/button_style.dart';


class PostButton extends ConsumerWidget {
  const PostButton({super.key, Function()? onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postViewModel = ref.watch(postViewModelProvider.notifier);

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