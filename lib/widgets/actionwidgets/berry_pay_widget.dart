import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../providers/berry_pay_provider.dart';
import '../../viewmodels/widgetsviewmodels/price_viewmodel.dart';
import '../profile_widget.dart/balance_widget.dart';

class UserProfile { // ユーザープロファイルクラス
  final String solanaAddress; // Solanaアドレス
  final String username; // ユーザー名

  UserProfile({required this.solanaAddress, required this.username}); // コンストラクタ

  get id => ""; // IDのゲッター
}

class BerryPayment extends ConsumerWidget { // BerryPaymentウィジェットクラス
  final UserProfile receiverProfile; // 受信者のプロファイル
  final UserProfile senderProfile; // 送信者のプロファイル
  final double price; // 価格
  const BerryPayment({super.key, 
    required this.receiverProfile,
    required this.senderProfile,
    required this.price,
  }); // コンストラクタ

  @override
  Widget build(BuildContext context, WidgetRef ref) { // ウィジェットのビルドメソッド
    // キャストを使用してPriceViewModelにアクセス
  final priceViewModel = ref.watch(priceViewModelProvider.notifier);
  Text('${priceViewModel.isPriceInBerry.toStringAsFixed(2)} berry'); // 現在の価格を表示
    final viewModel = ref.watch(paymentViewModelProvider); // ペイメントビューモデルをウォッチ
    return Scaffold( // スカフォールドを返す
      body: Column( // ボディにカラムを配置
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 子ウィジェットを均等に配置
        children: <Widget>[ // 子ウィジェットのリスト
          // RecipientQr and UserName
          Column( // 受信者のQRコードとユーザー名を表示するカラム
            children: <Widget>[
              QrImageView( // QRコードイメージビュー
                data: receiverProfile.solanaAddress, // 受信者のSolanaアドレスをデータとして設定
                version: QrVersions.auto, // QRバージョンを自動に設定
                size: 200.0, // サイズを200.0に設定
              ),
              Text(receiverProfile.username), // 受信者のユーザー名を表示
            ],
          ),
          // UpArrow and Price
          Row( // 上矢印と価格を表示する行
            mainAxisAlignment: MainAxisAlignment.center, // 子ウィジェットを中央に配置
            children: <Widget>[
              const Icon(Icons.arrow_upward), // 上矢印アイコンを表示
              const SizedBox(width: 10), // 幅10の空白を挿入
              Image.asset('assets/berryIcon_transparent.png', width: 20, height: 20), // ベリーアイコンを表示
              Text('${priceViewModel.isPriceInBerry.toStringAsFixed(2)} berry'), // 現在の価格を表示
            ],
          ),
          // SenderQr and UserName
          Column( // 送信者のQRコードとユーザー名を表示するカラム
            children: <Widget>[
              QrImageView( // QRコードイメージビュー
                data: senderProfile.solanaAddress, // 送信者のSolanaアドレスをデータとして設定
                version: QrVersions.auto, // QRバージョンを自動に設定
                size: 200.0, // サイズを200.0に設定
              ),
              Text(senderProfile.username), // 送信者のユーザー名を表示
            ],
          ),
          // PayButton
          ElevatedButton( // 支払いボタン
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, // 前景色を白に設定
              backgroundColor: Colors.green, // 背景色を緑に設定
            ),
            onPressed: () async {
              await viewModel.when(
                data: (data) async {
                  await data.sendPayment();
                },
                loading: () async {},
                error: (_, __) async {},
              );
            },
            child: const Text('Pay', style: TextStyle(fontFamily: 'Roboto')), // ボタンのテキストを設定
          ),
          // Show current balance
          const BalanceWidget(userId: '',), // 現在のバランスを表示するウィジェット
        ],
      ),
    );
  }
}