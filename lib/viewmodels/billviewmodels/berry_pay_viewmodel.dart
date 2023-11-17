

// berry_pay_viewmodel.dart
import '../../widgets/actionwidgets/berry_pay_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentViewModel {
  final UserProfile receiverProfile;
  final UserProfile senderProfile;
  final double amount;

  PaymentViewModel({required this.receiverProfile, required this.senderProfile, required this.amount});

  Future<void> sendPayment() async {
    final response = await http.post(
      Uri.parse('[Firebase FunctionのURL]'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'receiver': receiverProfile.id, // 受信者の識別子やアドレス
        'sender': senderProfile.id, // 送信者の識別子やアドレス
        'amount': amount.toString(), // 送金額
      }),
    );

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to send payment');
    }
  }
}
