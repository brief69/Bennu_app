

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/berry_pay_viewmodel.dart';
import '../widgets/actionwidgets/berry_pay_widget.dart';

final paymentViewModelProvider = Provider<PaymentViewModel>((ref) {
  // TODO: 必要な情報を取得してPaymentViewModelを初期化
  return PaymentViewModel(
    receiverProfile: UserProfile(solanaAddress: '', username: ''),
    senderProfile: UserProfile(solanaAddress: '', username: ''),
    amount: 100.0,
  );
});
