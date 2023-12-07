import 'package:flutter/material.dart';

class EffectSettings {
  String textOverlay;
  Color textColor;
  double fontSize;
  Offset textPosition;

  EffectSettings({
    this.textOverlay = "Hello Flutter!",
    this.textColor = Colors.white,
    this.fontSize = 20.0,
    this.textPosition = const Offset(100, 10),
  });

  // テキストオーバーレイの内容を更新するメソッド
  void updateTextOverlay(String newText) {
    textOverlay = newText;
  }

  // テキストの色を更新するメソッド
  void updateTextColor(Color newColor) {
    textColor = newColor;
  }

  // フォントサイズを更新するメソッド
  void updateFontSize(double newSize) {
    fontSize = newSize;
  }

  // テキストの位置を更新するメソッド
  void updateTextPosition(Offset newPosition) {
    textPosition = newPosition;
  }
}
