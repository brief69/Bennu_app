

// price_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceViewModel extends StateNotifier<bool> {
  static const int berryPrice = 300;
  // 仮に為替レートを1.0としてるが実際にはレートを取得する。
  static const num exchangeRate = 1.0;
  // TODO: 日本円の為替レートを取得して表示する 
  num get currentPrice => isBerry ? berryPrice : (berryPrice * exchangeRate);

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
  return PriceViewModel(true); // 初期状態として`true`を渡す
});
