

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/profilemodels/balance_model.dart';

final balanceProvider = StateProvider<BalanceModel>((ref) {
  // TODO: 初期値は0で設定、外部からデータを取得する
  return BalanceModel(balanceInSolana: 0.0, balanceInYen: 0.0);
});

final showBalanceProvider = StateProvider<bool>((ref) => true);
final currencyDisplayProvider = StateProvider<bool>((ref) => true); // true for Solana, false for Yen
