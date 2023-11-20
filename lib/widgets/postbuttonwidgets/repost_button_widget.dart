

// repost_button_widget.dart
import 'package:bennu_app/widgets/postbuttonwidgets/button_style.dart';
import 'package:flutter/material.dart';

class RePostButton extends StatelessWidget {
  const RePostButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        style: CustomButtonStyle.greenRoundedButtonStyle(),
        onPressed: () {
        // Firestoreにデータを保存する処理（RePostの場合）
        // repostの場合、
        // 動画は元の動画を参照されることもある。
        // captionが変わって、商品の異なる部分
        // もとの投稿のいいね数は参照するべきかな。
        // するべきだな。。
        // 
        },
        child: const Text('RePost'),
      )
    );
  }
}
