import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/viewmodels/main_page_viewmodel.dart';

// MainPageViewModelのインスタンスを提供するプロバイダーを定義
final mainPageViewModelProvider = ChangeNotifierProvider<MainPageViewModel>((ref) {
  return MainPageViewModel(); // MainPageViewModelのインスタンスを返す
});
