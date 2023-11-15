

// pay_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/widgetsviewmodels/pay_viewmodel.dart';
import '../viewmodels/widgetsviewmodels/price_viewmodel.dart';

// PayViewModelのプロバイダーの更新
final payViewModelProvider = StateNotifierProvider<PayViewModel, int>((ref) {
  final isBerry = ref.watch(priceViewModelProvider); // See Currency State
  return PayViewModel(isBerry);
});
