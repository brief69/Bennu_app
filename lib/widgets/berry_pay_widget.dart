

// berry_pay_widget.dart
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UserProfile {
  final String solanaAddress;
  final String username;

  UserProfile({required this.solanaAddress, required this.username});
}

class BerryPaymentTab extends StatelessWidget {
  final UserProfile receiverProfile;
  final UserProfile senderProfile;
  final double amount; // 例としての金額、実際のデータに置き換える

  const BerryPaymentTab({super.key, 
    required this.receiverProfile,
    required this.senderProfile,
    this.amount = 100.0, // デフォルトの例としての金額
  }); // TODO: #25 取得しなければならない

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // 受信者のQRコードとユーザー名
          Column(
            children: <Widget>[
              QrImage( // TODO: #26 QRの問題を解決しなければならない。
                data: receiverProfile.solanaAddress,
                version: QrVersions.auto,
                size: 200.0,
              ),
              Text(receiverProfile.username),
            ],
          ),

          // 矢印と金額
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.arrow_upward),
              const SizedBox(width: 10),
              Text('$amount berry'),
            ],
          ),

          // 送信者のQRコードとユーザー名
          Column(
            children: <Widget>[
              QrImage(
                data: senderProfile.solanaAddress,
                version: QrVersions.auto,
                size: 200.0,
              ),
              Text(senderProfile.username),
            ],
          ),
        ],
      ),
    );
  }
}

// TODO: #27 OKぼたんを配置して、タップするとバックエンドの処理が完了する
