import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PriceViewModel extends StateNotifier<bool> {
  static const int berryPrice = 300;
  num exchangeRate = 1.0;

  // 現在の価格を計算
  num get currentPriceInYen => berryPrice * exchangeRate;
  num get currentPriceInBerry => berryPrice;

  // 価格表記を円にするかberryにするかの状態管理
  bool isBerry = true;

  PriceViewModel(super.state) {
    _loadExchangeRateFromCache();
    _subscribeToFirestore();
  }

  get isPriceInBerry => null;

  void _loadExchangeRateFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    exchangeRate = prefs.getDouble('exchangeRate') ?? 1.0;
    state = !state; // UIを更新
  }

  void _subscribeToFirestore() {
    FirebaseFirestore.instance.collection('exchangeRates').doc('JPY')
      .snapshots().listen((snapshot) {
        if (snapshot.exists) {
          final data = snapshot.data();
          exchangeRate = data?['rate'] ?? 1.0;
          _saveExchangeRateToCache(exchangeRate);
          state = !state; // UIを更新
        }
      });
  }

  void _saveExchangeRateToCache(num rate) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('exchangeRate', rate.toDouble());
  }

  // 通貨切り替えロジック
  void toggleCurrency() {
    isBerry = !isBerry;
    state = !state; // 状態を更新してUIに変更を通知
  }
}

final priceViewModelProvider = StateNotifierProvider<PriceViewModel, bool>((ref) {
  return PriceViewModel(true); // PriceViewModelのインスタンスを返す
});
