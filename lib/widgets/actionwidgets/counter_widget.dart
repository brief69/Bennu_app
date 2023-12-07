import 'package:flutter/material.dart';
import '/viewmodels/media_viewmodel.dart';

// カウントウィジェットクラス
class CountWidget extends StatefulWidget {
  final int currentCount; // 現在のカウント
  final int maxCount; // 最大カウント
  final ValueChanged<int> onCountChanged; // カウント変更時のコールバック

  // コンストラクタ
  const CountWidget({
    Key? key,
    required this.currentCount,
    required this.maxCount,
    required this.onCountChanged, required MediaViewModel mediaItem,
  }) : super(key: key);

  // 状態オブジェクトを生成
  @override
  CountWidgetState createState() => CountWidgetState();
}

// カウントウィジェットの状態クラス
class CountWidgetState extends State<CountWidget> {
  late int currentCount; // 現在のカウント

  // 初期化処理
  @override
  void initState() {
    super.initState();
    currentCount = widget.currentCount;
  }

  // カウントを増やす
  void _incrementCount() {
    if (currentCount < widget.maxCount) {
      setState(() {
        currentCount++;
        widget.onCountChanged(currentCount);
      });
    }
  }

  // カウントを減らす
  void _decrementCount() {
    if (currentCount > 0) {
      setState(() {
        currentCount--;
        widget.onCountChanged(currentCount);
      });
    }
  }

  // ウィジェットを描画
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: _decrementCount,
        ),
        Text('$currentCount'),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _incrementCount,
        ),
      ],
    );
  }
}
