import 'package:bennu/models/homewidgetmodels/media_model.dart';
import 'package:bennu/viewmodels/home_viewmodel.dart';
import 'package:bennu/viewmodels/media_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/cart_viewmodel.dart';
import '../actionwidgets/counter_widget.dart';

class InCartWidget extends StatefulWidget {
  final String productId;
  final int stock;
  final int initialInCart;

  const InCartWidget({ // コンストラクタを定義します。
    Key? key,
    required this.productId,
    required this.stock,
    required this.initialInCart, required String postId,
  }) : super(key: key);

  @override
  InCartWidgetState createState() => InCartWidgetState(); // 状態を管理するクラスを作成します。
}

class InCartWidgetState extends State<InCartWidget> { // InCartWidgetの状態を管理するクラスを定義します。
  bool isExpanded = false; // ウィジェットが展開されているかどうかを管理する変数を定義します。
  late int inCart; // カート内の数量を管理する変数を定義します。

  @override
  void initState() { // 初期化メソッドを定義します。
    super.initState();
    inCart = widget.initialInCart; // 初期化時にカート内の数量を設定します。
  }

  void _toggleExpansion() { // ウィジェットの展開/折りたたみを切り替えるメソッドを定義します。
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void _updateInCart(int newInCart, WidgetRef ref) { // カート内の数量を更新するメソッドを定義します。
    setState(() {
      inCart = newInCart;
    });
    // カートの数量を更新
    ref.read(cartProvider.notifier).updateQuantity(widget.productId, newInCart); // カートの数量を更新します。
  }

  @override
  Widget build(BuildContext context) { // ウィジェットを描画するメソッドを定義します。
    return Consumer(
      builder: (context, ref, child) {
        return GestureDetector(
          onTap: _toggleExpansion, // タップ時にウィジェットの展開/折りたたみを切り替えます。
          child: AnimatedContainer(
            duration: const Duration(seconds: 3), // アニメーションの時間を設定します。
            curve: Curves.fastOutSlowIn, // アニメーションのカーブを設定します。
            width: isExpanded ? 200 : 100, // ウィジェットの幅を設定します。
            height: 50, // ウィジェットの高さを設定します。
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(isExpanded ? 1 : 0.5), // ウィジェットの色を設定します。
              borderRadius: BorderRadius.circular(8), // ウィジェットの角を丸くします。
            ),
            child: isExpanded
                ? CountWidget(
                    currentCount: inCart, // 現在の数量を設定します。
                    maxCount: widget.stock, // 最大数量を設定します。
                    onCountChanged: (newCount) => _updateInCart(newCount, ref), mediaItem: MediaViewModel(mediaViewModelProvider as MediaModel), // 数量が変更されたときの処理を設定します。
                  )
                : Center(
                    child: Text(
                      'In Cart ($inCart)', // カート内の数量を表示します。
                      style: const TextStyle(color: Colors.white), // テキストのスタイルを設定します。
                    ),
                  ),
          ),
        );
      },
    );
  }
}

