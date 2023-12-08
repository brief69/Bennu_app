import 'package:bennu/widgets/delivery_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/viewmodels/cart_viewmodel.dart';
import '/viewmodels/media_viewmodel.dart';
import '/widgets/actionwidgets/berry_pay_widget.dart';
import '/widgets/grid_view_widget.dart';
import '/widgets/homebuttonwidgets/buy_button_widget.dart';
import '/widgets/actionwidgets/counter_widget.dart';


class CartView extends ConsumerWidget { // カートビュークラス（ConsumerWidgetを継承）
  const CartView({super.key}); // コンストラクタ

  @override
  Widget build(BuildContext context, WidgetRef ref) { // ビルドメソッド
    final cartItems = ref.watch(cartProvider); // カート内のアイテムを監視
    final theme = Theme.of(context); // テーマデータの取得

    // 合計金額の計算
    String totalPrice = "¥${cartItems.fold(0, (total, item) => total + item.price).toStringAsFixed(2)}";

    UserProfile receiverProfile = UserProfile( // 受信者プロファイルの作成
      solanaAddress: "受信者のSolanaアドレス",
      username: "受信者のユーザー名"
    );
    UserProfile senderProfile = UserProfile( // 送信者プロファイルの作成
      solanaAddress: "送信者のSolanaアドレス",
      username: "送信者のユーザー名"
    );
    
    return Scaffold( // スカフォールドの返却
      appBar: AppBar( // アプリバーの設定
        title: const DeliveryWidget(),
        backgroundColor: theme.appBarTheme.backgroundColor, // アプリバーの背景色の設定
      ),
      body: GridViewWidget( // ボディにグリッドビューウィジェットを配置
        mediaList: cartItems.map((item) => MediaViewModel(item)).toList(), // カート内の商品リストをMediaViewModelに変換
        pageType: PageType.cart, // ページタイプの設定
        customItemBuilder: (mediaItem) => Column( // カスタムアイテムビルダーの設定
          children: [
            CountWidget( // カウントウィジェットの表示
              mediaItem: mediaItem, 
              currentCount: 1, 
              maxCount: 10,
              onCountChanged: (int value) { // カウントが変更されたときの処理
                ref.read(cartProvider.notifier).updateItemCount(mediaItem.id, value); // アイテムカウントの更新
              },
            ),
            Text('Price: ¥${mediaItem.price.toStringAsFixed(2)}'), // 価格の表示
          ],
        ),
      ),
      bottomNavigationBar: Visibility( // Visibilityウィジェットを使用して購入ボタンの表示/非表示を制御
        visible: cartItems.isNotEmpty, // カートにアイテムがある場合のみ表示
        child: Padding( // ボトムナビゲーションバーの設定
          padding: const EdgeInsets.all(8.0), // パディングの設定
          child: BuyButton( // 購入ボタンの配置
            price: totalPrice, // 価格の設定
            isExtendedByDefault: true, // デフォルトで拡張されているかの設定
            receiverProfile: receiverProfile, // 受信者プロファイルの設定
            senderProfile: senderProfile, // 送信者プロファイルの設定
          ),
        ),
      ),
    );
  }
}
