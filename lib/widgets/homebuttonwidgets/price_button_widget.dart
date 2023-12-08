import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/viewmodels/widgetsviewmodels/price_viewmodel.dart';

// 価格を表示するウィジェット
class PriceWidget extends ConsumerWidget {
  //final int priceInYen; // 価格(円)
  // コンストラクタ（価格引数は不要になる）
  const PriceWidget({Key? key, required int priceInYen}) : super(key: key);

  // ウィジェットのビルド
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 価格表示のモードを取得
    final isBerry = ref.watch(priceViewModelProvider);
    // 価格表示のモデルを取得
    final priceViewModel = ref.watch(priceViewModelProvider.notifier);

    // 価格表示の文字列を生成
    String displayPrice = isBerry
      ? '${priceViewModel.currentPriceInBerry.toStringAsFixed(2)} berry' 
      : '¥${priceViewModel.currentPriceInYen.toStringAsFixed(2)}';

    // タップ可能なウィジェットを返す
    return InkWell(
      onTap: () => priceViewModel.toggleCurrency(),
      child: Container(
        // パディング設定
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        // デコレーション設定
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.blue), // 任意の境界線色
          borderRadius: BorderRadius.circular(4.0),
        ),
        // 価格表示テキスト
        child: Text(
          displayPrice,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
