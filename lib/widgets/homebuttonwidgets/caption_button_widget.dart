

// caption_button_widget.dart
import 'package:flutter/material.dart';

class CaptionButtonWidget extends StatelessWidget {
  final String caption; // キャプションのテキスト

  const CaptionButtonWidget({Key? key, required this.caption}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showFullCaption(context),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.transparent,
        child: Text(
          caption,
          style: const TextStyle(color: Colors.white),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  void _showFullCaption(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: SingleChildScrollView(
            child: Text(
              caption,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
// このコードは、mediawidgetで以下のように使用する
// CaptionButtonWidget(caption: 'ここにキャプションのテキストを挿入') // キャプションを指定してウィジェットを作成
