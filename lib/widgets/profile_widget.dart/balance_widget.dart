import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/balance_provider.dart';

class BalanceWidget extends ConsumerWidget { // ConsumerWidgetを継承したBalanceWidgetクラス
  const BalanceWidget({super.key, required String userId}); // コンストラクタ

  @override
  Widget build(BuildContext context, WidgetRef ref) { // ビルドメソッド
    final balance = ref.watch(balanceProvider); // バランスプロバイダーを監視
    final showBalance = ref.watch(showBalanceProvider); // 表示バランスプロバイダーを監視
    final currencyDisplay = ref.watch(currencyDisplayProvider); // 通貨表示プロバイダーを監視

    return Column( // Columnウィジェットを返す
      children: <Widget>[ // 子ウィジェットのリスト
        // 金額表示
        Visibility( // Visibilityウィジェット
          visible: showBalance, // showBalanceがtrueの場合、ウィジェットを表示
          child: GestureDetector( // GestureDetectorウィジェット
            onTap: () => ref.read(currencyDisplayProvider.state).state = !currencyDisplay, // タップ時に通貨表示を切り替え
            child: Text( // Textウィジェット
              currencyDisplay ? '${balance.balanceInSolana} b' : '¥${balance.balanceInYen}', // 通貨表示に応じてテキストを変更
              style: const TextStyle(fontSize: 24), // テキストスタイル
            ),
          ),
        ),
        IconButton( // IconButtonウィジェット
          icon: Icon(showBalance ? Icons.visibility : Icons.visibility_off), // showBalanceに応じてアイコンを切り替え
          onPressed: () => ref.read(showBalanceProvider.state).state = !showBalance, // ボタン押下時に表示バランスを切り替え
        ),
      ],
    );
  }
}