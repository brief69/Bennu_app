import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/viewmodels/widgetsviewmodels/pay_viewmodel.dart';
import '/viewmodels/widgetsviewmodels/price_viewmodel.dart';

// PayViewModelのプロバイダーの更新
// StateNotifierProviderを使用して、PayViewModelの状態を管理します
final payViewModelProvider = StateNotifierProvider<PayViewModel, int>((ref) {
  // priceViewModelProviderから現在の通貨状態を取得します
  final isBerry = ref.watch(priceViewModelProvider); // See Currency State
  // PayViewModelを初期化し、現在の通貨状態を渡します
  return PayViewModel(isBerry);
});
