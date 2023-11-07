

// box_viewmodel.dart
import 'package:bennu_app/models/search_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final boxProvider = StateNotifierProvider<BoxViewModel, List<Product>>((ref) => BoxViewModel());

class BoxViewModel extends StateNotifier<List<Product>> {
  BoxViewModel() : super([]);

  late final firestore = FirebaseFirestore.instance;

  Future<void> fetchBoxItems() async {
    // ユーザーIDに基づいてカート内の商品を取得（例として）
    final boxItems = await firestore.collection('cartItems').where('userId', isEqualTo: 'YOUR_USER_ID').get();
    state = boxItems.docs.map((doc) => Product(
      id: doc.id,
      name: doc['name'],
      imageUrl: doc['imageUrl'],
      price: doc['price'],
      quantity: doc['quantity'],
    )).toList();
  }

  void updateQuantity(String productId, int change) {
    state = state.map((product) {
      if (product.id == productId) {
        product.quantity += change;
      }
      return product;
    }).toList();
  }

  void removeProduct(String productId) {
    state = state.where((product) => product.id != productId).toList();
  }

  double get totalAmount => state.fold(0.0, (sum, product) => sum + product.totalPrice);
}
