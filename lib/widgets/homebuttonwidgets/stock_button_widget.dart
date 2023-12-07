
import 'package:flutter/material.dart';


class StockWidget extends StatelessWidget {
  final int stockCount; // 在庫数

  const StockWidget({Key? key, required this.stockCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            stockCount.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'stock',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

// mediawidgetで、以下のように使用する
// StockWidget(stockCount: 5) // 在庫数を指定してウィジェットを作成
