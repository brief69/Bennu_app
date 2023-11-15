

// berry_pay_viewmodel.dart

import '../widgets/actionwidgets/berry_pay_widget.dart';

class PaymentViewModel {
  final UserProfile receiverProfile;
  final UserProfile senderProfile;
  final double amount;

  PaymentViewModel({required this.receiverProfile, required this.senderProfile, required this.amount});

  Future<void> sendPayment() async {
    // TODO: バックエンドへの支払いリクエストを実装
  }
}
