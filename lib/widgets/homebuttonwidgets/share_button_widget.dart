import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

// ShareWidgetは、テキストを共有するウィジェットです。
class ShareWidget extends StatelessWidget {
  final String textToShare; // 共有するテキスト
  final String? subject; // 共有するテキストの件名

  // コンストラクタ。共有するテキストとその件名をパラメータとして受け取ります。
  const ShareWidget({
    Key? key,
    required this.textToShare,
    this.subject,
  }) : super(key: key);

  // ウィジェットを描画します。
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.share), // 共有アイコン
      onPressed: () => _onShare(context), // 共有ボタンが押されたときの動作
      tooltip: 'Share', // ツールチップテキスト
    );
  }

  // 共有機能を実装します。
  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?; // RenderBoxを取得
    await Share.share(
      textToShare, // 共有するテキスト
      subject: subject, // 件名
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size, // 共有元の位置
    );
  }
}