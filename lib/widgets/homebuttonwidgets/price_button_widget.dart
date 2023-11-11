

 // price_button_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/widgetsviewmodels/price_viewmodel.dart';


class PriceWidget extends ConsumerWidget {
  final int priceInYen; // 価格(円)

  const PriceWidget({Key? key, required this.priceInYen}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBerry = ref.watch(priceViewModelProvider);
    final priceViewModel = ref.read(priceViewModelProvider.notifier);

    String displayPrice = isBerry ? '${(priceInYen / PriceViewModel.berryPrice).toStringAsFixed(2)} berry' : '¥$priceInYen';

    return InkWell(
      onTap: () {
        // モーダル遷移の画面を表示するロジック
        priceViewModel.toggleCurrency(); // 通貨の表示を切り替える
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.blue), // 任意の境界線色
          borderRadius: BorderRadius.circular(4.0),
        ),
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
