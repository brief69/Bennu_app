

// other_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final otherViewModelProvider = ChangeNotifierProvider((ref) => OtherViewModel());
class OtherViewModel extends ChangeNotifier {

  void handleMenuAction(String value) {
    switch (value) {
      case 'report':
        // 報告のロジックを処理する
        break;
      case 'block':
        // 通報のロジックを処理する
        break;
      case 'hide':
        // 非表示のロジックを処理する
        break;
      // 他のケースもここに追加
    }
    notifyListeners(); // 必要に応じてリスナーに通知
  }

  // 他のビジネスロジック
}
