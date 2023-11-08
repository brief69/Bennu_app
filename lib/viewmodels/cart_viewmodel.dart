

// box_viewmodel.dart
import 'package:bennu_app/models/search_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final cartProvider = StateNotifierProvider<CartViewModel, List<Product>>((ref) => CartViewModel());

class CartViewModel extends StateNotifier<List<Product>> {
  CartViewModel() : super([]);

  late final firestore = FirebaseFirestore.instance;

  Future<void> fetchCartItems() async {
    // ユーザーIDに基づいてカート内の商品を取得
    final cartItems = await firestore.collection('cartItems').where('userId', isEqualTo: 'YOUR_USER_ID').get();
    state = cartItems.docs.map((doc) => Product(
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
