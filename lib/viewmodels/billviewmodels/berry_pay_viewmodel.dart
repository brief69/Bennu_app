import 'package:http/http.dart' as http;
import 'dart:convert';
import '/widgets/actionwidgets/berry_pay_widget.dart';
// 支払いに関するビューモデル
class PaymentViewModel {
  final UserProfile receiverProfile; // 受信者のプロフィール
  final UserProfile senderProfile; // 送信者のプロフィール
  final double amount; // 送金額

  // コンストラクタ
  PaymentViewModel({required this.receiverProfile, required this.senderProfile, required this.amount});

  // 支払いを送信するメソッド
  Future<void> sendPayment() async {
    // Firebase FunctionにPOSTリクエストを送信
    final response = await http.post(
      Uri.parse('[Firebase FunctionのURL]'), // Firebase FunctionのURL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8', // ヘッダー情報
      },
      body: jsonEncode(<String, String>{ // ボディ情報
        'receiver': receiverProfile.id, // 受信者の識別子やアドレス
        'sender': senderProfile.id, // 送信者の識別子やアドレス
        'amount': amount.toString(), // 送金額
      }),
    );

    // レスポンスのステータスコードが200でなければ例外をスロー
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to send payment');
    }
  }
}
