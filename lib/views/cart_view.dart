

// box_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/cart_viewmodel.dart';

class BoxView extends ConsumerWidget {
  const BoxView({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final boxItems = ref.watch(boxProvider);

    return Scaffold(
      appBar: AppBar(
        // appbarには、配送状況に応じて左から右に現在のステータスが表示されるようにする。
        // 配送apiは、別のモジュールで管理する。
      ),
      body: ListView.builder(
        itemCount: boxItems.length,
        itemBuilder: (ctx, index) {
          final product = boxItems[index];
          return ListTile(
            leading: Image.network(product.imageUrl),
            title: Text(product.name),
            subtitle: Text("¥${product.totalPrice.toStringAsFixed(2)}"),
            trailing: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    ref.read(boxProvider.notifier).updateQuantity(product.id, -1);
                  },
                ),
                Text("${product.quantity}"),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    ref.read(boxProvider.notifier).updateQuantity(product.id, 1);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ref.read(boxProvider.notifier).removeProduct(product.id);
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("合計: ¥${ref.read(boxProvider.notifier).totalAmount.toStringAsFixed(2)}"),
        ),
      ),
    );
  }
}


// stockの数は、左にマイナス、右にプラス、中心に現在の数が表示される。0にすると、商品がカートから削除される。
// カートの中身の合計金額は、カートの中身の商品の合計金額の合計金額を表示する
// 一つ一つの商品は、gridviewで表示し、各グリッドは商品のmedia、price、stockの数、が表示れる。
// グリッドをタップすると、商品の詳細ページに飛び、そのページではカート内の商品のみをlistviewで閲覧できる。
// 商品の個数を増減すると、合計金額が変わる