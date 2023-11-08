

// box_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/cart_viewmodel.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        // 
        // TODO: #13 appbarには、配送状況に応じて左から右に現在のステータスが表示されるようにする。配送apiは、別のモジュールで管理する。
        // TODO: #16 delivery_widgetをここで呼び出す
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (ctx, index) {
          final product = cartItems[index];
          return ListTile(
            leading: Image.network(product.imageUrl),
            title: Text(product.name),
            subtitle: Text("¥${product.totalPrice.toStringAsFixed(2)}"),
            trailing: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    ref.read(cartProvider.notifier).updateQuantity(product.id, -1);
                  },
                ),
                Text("${product.quantity}"),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    ref.read(cartProvider.notifier).updateQuantity(product.id, 1);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ref.read(cartProvider.notifier).removeProduct(product.id);
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
          child: Text("合計: ¥${ref.read(cartProvider.notifier).totalAmount.toStringAsFixed(2)}"),
        ),
      ),
    );
  }
}

// TODO: #12 このページで用いるwidget　→ BuyButton,Counter,Price,gridview,

// 

// stockの数は、左にマイナス、右にプラス、中心に現在の数が表示される。0にすると、商品がカートから削除される。
// カートの中身の合計金額は、カートの中身の商品の合計金額の合計金額を表示する
// 一つ一つの商品は、gridviewで表示し、各グリッドは商品のmedia、price、stockの数、が表示れる。
// グリッドをタップすると、商品の詳細ページに飛び、そのページではカート内の商品のみをlistviewで閲覧できる。
// 商品の個数を増減すると、合計金額が変わる