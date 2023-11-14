

// pay_widget.dart
import 'dart:io';

import 'package:flutter/material.dart';

class PayWidget extends StatefulWidget {
  final double price; // 価格は外部から渡される

  const PayWidget({Key? key, required this.price}) : super(key: key);

  @override
  PayWidgetState createState() => PayWidgetState();
}

class PayWidgetState extends State<PayWidget> {
  int selectedIndex = 0; // タブの選択状態

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBar(
            tabs: const [
              Tab(text: 'Apple/Google Pay'),
              Tab(text: 'Berry'),
            ],
            onTap: (index) {
              setState(() {
              selectedIndex = index;
              });
            },
          ),
          // タブビュー
          Expanded(
            child: TabBarView(
              children: [
                _appleGooglePayTab(),
                berryPaymentTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _appleGooglePayTab() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (Platform.isIOS) {
            // Apple Payの決済処理を呼び出す
          } else if (Platform.isAndroid) {
            // Google Payの決済処理を呼び出す
          }
        },
        child: const Text('Pay with Apple/Google Pay'),
      ),
    );
  }

  Widget berryPaymentTab() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // TODO: berryの処理を呼び出す
        },
        child: const Text('berry'),
      ),
    );
  }
}
