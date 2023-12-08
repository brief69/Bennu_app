import 'package:flutter/material.dart';

// StockWidgetは、在庫数を表示するウィジェットです。
class StockWidget extends StatelessWidget {
  final int stockCount; // 在庫数

  // コンストラクタ。在庫数を必須パラメータとして受け取ります。
  const StockWidget({Key? key, required this.stockCount}) : super(key: key);

  // ウィジェットを描画します。
  @override
  Widget build(BuildContext context) {
    // 在庫数とそのラベルを含むコンテナを返します。
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // 在庫数を表示します。
          Text(
            stockCount.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          // 'stock'ラベルを表示します。
          const Text(
            'stock',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}