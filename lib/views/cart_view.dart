
// cart_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/cart_viewmodel.dart';
import '../viewmodels/media_viewmodel.dart';
import '../widgets/actionwidgets/berry_pay_widget.dart';
import '../widgets/grid_view_widget.dart';
import '../widgets/homebuttonwidgets/buy_button_widget.dart';


class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final theme = Theme.of(context);

    // 合計金額の計算
    String totalPrice = "¥${cartItems.fold(0, (total, item) => total + item.price).toStringAsFixed(2)}";

    UserProfile receiverProfile = UserProfile(
      solanaAddress: "受信者のSolanaアドレス",
      username: "受信者のユーザー名"
    );
    UserProfile senderProfile = UserProfile(
      solanaAddress: "送信者のSolanaアドレス",
      username: "送信者のユーザー名"
    );
    
    return Scaffold(
      appBar: AppBar(
        // TODO: #40 // delvery_widget.dartを配置
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: GridViewWidget(
        mediaList: cartItems.map((item) => MediaViewModel(item)).toList(), // カート内の商品リストをMediaViewModelに変換
        pageType: PageType.cart,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BuyButton(
          price: totalPrice,
          isExtendedByDefault: true, 
          receiverProfile: receiverProfile,
          senderProfile: senderProfile,
        ),
      ),
    );
  }
}
