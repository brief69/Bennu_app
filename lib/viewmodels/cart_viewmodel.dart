

// vart_viewmodel.dart
import 'package:bennu_app/models/media_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// カートアイテムの状態を管理するプロバイダ
final cartProvider = StateNotifierProvider<CartViewModel, List<MediaModel>>((ref) {
  return CartViewModel();
});

class CartViewModel extends StateNotifier<List<MediaModel>> {
  CartViewModel() : super([]);

  // カート内の合計金額を計算
  double get totalPrice => state.fold(0, (total, item) => total + item.price);
  
  Object? get mediaId => null;

  // MediaModelをカートに追加
  void addItem(MediaModel item) {
    state = [...state, item];
  }

  // 商品の数量を更新
  void updateQuantity(String itemId, int newQuantity) {
    state = state.map((item) {
      if (item.postId == mediaId) {
        return item.copyWith(quantity: newQuantity);
      }
      return item;
    }).toList();
  }

  // 商品をカートから削除
  void removeItem(String itemId) {
    state = state.where((item) => item.postId != mediaId).toList();
  }

  // その他の必要なメソッド
}
