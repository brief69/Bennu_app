// カスタムコンテンツを表すクラス
import 'package:bennu/models/user.dart';

class CustomContent {
  final String name; // コンテンツの名前
  final String imageUrl; // コンテンツの画像URL

  CustomContent({required this.name, required this.imageUrl});
}

// 商品を表すクラス
class Product {
  final String name; // 商品の名前
  final String imageUrl; // 商品の画像URL
  final String id; // 商品のID
  final double? price; // 商品の価格（null許容型）
  final int? quantity; // 商品の数量（null許容型）

  Product({
    required this.name, 
    required this.imageUrl, 
    required this.id, 
    this.price, 
    this.quantity,
  });

  double get totalPrice => price ?? 0.0; // 合計価格を取得するゲッター
  int get totalQuantity => quantity ?? 0; // 数量を取得するゲッター
}

// 検索結果を表すクラス
class SearchResult {
  final List<CustomContent>? sites;
  final List<Product>? products;
  final List<User>? users;

  SearchResult({this.sites, this.products, this.users});

  get searchController => null;

  void fetchSearchResults(String query) {}
}
