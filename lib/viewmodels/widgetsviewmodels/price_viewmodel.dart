

// price_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceViewModel extends StateNotifier<bool> {
  static const int berryPrice = 300; // 1berryの価格

  // 価格表記を円にするかberryにするかの状態管理
  bool isBerry = true;

  PriceViewModel(super.state); // デフォルトはberry表記

  // 通貨切り替えロジック
  void toggleCurrency() {
    isBerry = !isBerry;
    // 他の状態管理が必要な場合はここで処理
  }
}

final priceViewModelProvider = StateNotifierProvider<PriceViewModel, bool>((ref) {
  return PriceViewModel(PriceViewModel as bool);
});
