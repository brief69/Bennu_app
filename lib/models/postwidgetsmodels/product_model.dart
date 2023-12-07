class Product {
  num price;
  bool isPriceInBerry; // trueの場合はberry、falseの場合は円

  Product({required this.price, this.isPriceInBerry = true});

  Product copyWith({required num price, required bool isPriceInBerry}) {
    return Product(price: price, isPriceInBerry: isPriceInBerry);
  }
}
