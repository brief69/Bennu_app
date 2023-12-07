import 'package:flutter/material.dart';

// CustomButtonStyleは、カスタムボタンのスタイルを定義するクラスです。
class CustomButtonStyle {
  // greenRoundedButtonStyleは、緑色の丸みを帯びたボタンスタイルを返します。
  static ButtonStyle greenRoundedButtonStyle() {
    // ElevatedButton.styleFromメソッドを使用して、ボタンスタイルを定義します。
    return ElevatedButton.styleFrom(
      // ボタンの前景色を白に設定します。
      foregroundColor: Colors.white,
      // ボタンの背景色を緑に設定します。
      backgroundColor: Colors.green,
      // ボタンのパディングを設定します。水平方向は30、垂直方向は10です。
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      // ボタンの形状を設定します。ここでは、角の丸みを30に設定した四角形を使用します。
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
