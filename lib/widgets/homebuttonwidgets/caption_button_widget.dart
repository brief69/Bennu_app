import 'package:flutter/material.dart';

// CaptionButtonWidgetは、キャプションを表示するウィジェットです。
class CaptionButtonWidget extends StatelessWidget {
  final String caption; // キャプションのテキスト

  // コンストラクタ。キャプションのテキストを必須パラメータとして受け取ります。
  const CaptionButtonWidget({Key? key, required this.caption}) : super(key: key);

  // ウィジェットを描画します。
  @override
  Widget build(BuildContext context) {
    // GestureDetectorを使用して、長押しを検出します。
    return GestureDetector(
      // 長押しされたときに、_showFullCaptionメソッドを呼び出します。
      onLongPress: () => _showFullCaption(context),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.transparent,
        // キャプションのテキストを表示します。テキストが長すぎる場合は省略します。
        child: Text(
          caption,
          style: const TextStyle(color: Colors.white),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  // _showFullCaptionメソッドは、ダイアログを表示してキャプションの全文を表示します。
  void _showFullCaption(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: SingleChildScrollView(
            // ダイアログの中にキャプションの全文を表示します。
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
