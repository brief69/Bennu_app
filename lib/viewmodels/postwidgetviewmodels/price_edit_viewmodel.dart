import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bennu/models/postwidgetsmodels/product_model.dart';

final priceEditViewModelProvider = StateNotifierProvider<PriceEditViewModel, Product>(
  (ref) => PriceEditViewModel(),
);

class PriceEditViewModel extends StateNotifier<Product> {
  PriceEditViewModel() : super(Product(price: 0, isPriceInBerry: true));

  void setPrice(num newPrice) {
    state = state.copyWith(price: newPrice, isPriceInBerry: state.isPriceInBerry);
  }

  void toggleCurrency() {
    state = state.copyWith(price: state.price, isPriceInBerry: !state.isPriceInBerry);
  }
}
