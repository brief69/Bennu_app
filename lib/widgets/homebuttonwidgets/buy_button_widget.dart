import 'dart:async';
import 'package:flutter/material.dart';
import '/widgets/actionwidgets/berry_pay_widget.dart';
import '/widgets/actionwidgets/pay_widget.dart';


class BuyButton extends StatefulWidget { // 購入ボタンの状態を管理するStatefulWidgetを定義します。
  final double defaultWidth; // ボタンのデフォルトの幅を定義します。
  final String price; // 価格を定義します。
  final bool isExtendedByDefault; // ボタンがデフォルトで拡張されているかどうかを定義します。
  final UserProfile receiverProfile; // 受信者のプロフィールを定義します。
  final UserProfile senderProfile; // 送信者のプロフィールを定義します。
  
  const BuyButton({ // コンストラクタを定義します。
  super.key, 
  this.defaultWidth = 150.0, 
  required this.price, 
  this.isExtendedByDefault = false,
  required this.receiverProfile, 
  required this.senderProfile,
});

  @override
  BuyButtonState createState() => BuyButtonState(); // 状態オブジェクトを生成します。
}

class BuyButtonState extends State<BuyButton> with SingleTickerProviderStateMixin { // BuyButtonの状態を管理するクラスを定義します。
  late AnimationController _animationController; // アニメーションコントローラを定義します。
  late Timer _timer; // タイマーを定義します。
  late double width; // 幅を定義します。
  bool _isExtended = false; // ボタンが拡張されているかどうかを定義します。

  @override
  void initState() { // 初期化メソッドを定義します。
    super.initState();

    _isExtended = widget.isExtendedByDefault; // ボタンがデフォルトで拡張されているかどうかを設定します。
      width = _isExtended ? 250.0 : widget.defaultWidth; // 幅を設定します。

    _animationController = AnimationController( // アニメーションコントローラを初期化します。
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) { // ウィジェットをビルドするメソッドを定義します。
    return GestureDetector( // ジェスチャー検出ウィジェットを返します。
      onTap: () { // タップ時の動作を定義します。
        _launchPayment(); // 支払いを開始します。
        if (_isExtended) { // ボタンが拡張されている場合
          _resetWidth(); // 幅をリセットします。
        } else { // ボタンが拡張されていない場合
          _extendButton(); // ボタンを拡張します。
        }
      },
      onLongPress: _extendButton, // 長押し時の動作を定義します。
      child: Container( // 子ウィジェットとしてコンテナを定義します。
        width: width, // 幅を設定します。
        height: 50, // 高さを設定します。
        decoration: BoxDecoration( // デコレーションを設定します。
          color: const Color.fromARGB(255, 0, 0, 96), // 色を設定します。
          borderRadius: BorderRadius.circular(8.0), // ボーダーラジウスを設定します。
          border: Border.all( // ボーダーを設定します。
            color: Colors.blue[200]!.withOpacity(0.6 * _animationController.value), // 色と透明度を設定します。
            width: 2.0, // 幅を設定します。
          ),
        ),
        child: Center( // 子ウィジェットとしてセンターを定義します。
          child: _isExtended ? Text(widget.price, style: const TextStyle(color: Colors.white)) : const Text("Buy", style: TextStyle(color: Colors.white)), // テキストを設定します。
        ),
      ),
    );
  }

  void _extendButton() { // ボタンを拡張するメソッドを定義します。
    setState(() { // 状態を更新します。
      width = 250.0; // 幅を設定します。
      _isExtended = true; // ボタンを拡張します。
    });
    _timer = Timer(const Duration(seconds: 9), _resetWidth); // タイマーを設定します。
  }

  void _resetWidth() { // 幅をリセットするメソッドを定義します。
    if (_timer.isActive) { // タイマーがアクティブな場合
      _timer.cancel(); // タイマーをキャンセルします。
    }
    setState(() { // 状態を更新します。
      width = widget.defaultWidth; // 幅をリセットします。
      _isExtended = false; // ボタンを非拡張にします。
    });
  }

  void _launchPayment() { // 支払いを開始するメソッドを定義します。
    showModalBottomSheet( // モーダルボトムシートを表示します。
    context: context,
    builder: (BuildContext context) {
      return PayWidget( // ペイウィジェットを返します。
        price: double.parse(widget.price), // 価格を設定します。
        receiverProfile: widget.receiverProfile, // 受信者のプロフィールを設定します。
        senderProfile: widget.senderProfile, // 送信者のプロフィールを設定します。
      );
    },
  );
}

  @override
  void dispose() { // リソースを解放するメソッドを定義します。
    _animationController.dispose(); // アニメーションコントローラを解放します。
    if (_timer.isActive) { // タイマーがアクティブな場合
      _timer.cancel(); // タイマーをキャンセルします。
    }
    super.dispose(); // スーパークラスのdisposeメソッドを呼び出します。
  }
}