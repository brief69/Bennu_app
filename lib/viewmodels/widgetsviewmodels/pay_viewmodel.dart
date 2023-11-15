

// pay_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PayViewModel extends StateNotifier<int> {
  PayViewModel(bool isBerry) : super(isBerry ? 1 : 0);

  void selectTab(int index) {
    state = index;
  }
}