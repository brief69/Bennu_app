

// search_model.dart
class CustomContent {
  final String name;
  final String imageUrl;

  CustomContent({required this.name, required this.imageUrl});
}

class Product {
  final String name;
  final String imageUrl;

  Product({required this.name, required this.imageUrl, required String id, required price, required quantity});

  get totalPrice => '';

  String? get id => '';

  get quantity => '';
}

class SearchResult {
  final List<CustomContent> sites;
  final List<Product> products;

  SearchResult({required this.sites, required this.products});

  get searchController => null;

  get users => null;

  void fetchSearchResults(String query) {}
}
