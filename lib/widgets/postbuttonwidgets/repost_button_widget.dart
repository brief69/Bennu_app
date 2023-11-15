

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
        },
        child: const Text('RePost'),
      )
    );
  }
}
