import 'package:flutter/foundation.dart';

// メインページのビューモデル
class MainPageViewModel extends ChangeNotifier {
  // 現在のタブのインデックス
  int _currentIndex = 0;

  // 現在のタブのインデックスを取得するゲッター
  int get currentIndex => _currentIndex;

  // タブのインデックスを変更するメソッド
  void changeIndex(int index) {
    // 現在のインデックスと新しいインデックスが異なる場合のみ更新
    if (_currentIndex != index) {
      _currentIndex = index;
      // 状態の変更をリスナーに通知
      notifyListeners();
    }
  }
}
