

// payment_model.dart
// 固定値を返すのではなく、きちんとした実装を誰かおこなってください

class PaymentModel {
  Future<double> getPostDataPrice() async {
    // TODO #3:実際の価格情報を取得するロジックを実装します
    // 今回はダミーとして固定値を返しています
    return 10.99;
  }

  Future<String> createPaymentIntentOnServer(double amount) async {
    // TODO #4:サーバーサイドとの通信を行い、paymentIntentClientSecretを取得するロジックを実装します
    // こちらもダミーとして固定値を返しています
    return "sample_secret_key";
  }
}
