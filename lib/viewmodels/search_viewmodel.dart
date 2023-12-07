import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';
import '../models/search_model.dart';

final searchProvider = StateNotifierProvider<SearchViewModel, SearchResult>((ref) => SearchViewModel());

class SearchViewModel extends StateNotifier<SearchResult> {
  SearchViewModel() : super(SearchResult(sites: [], products: []));

  final TextEditingController searchController = TextEditingController();

  Future<List<T>> _fetchFromFirestore<T>(String collection, String query, T Function(Map<String, dynamic>) fromMap) async {
    final firestore = FirebaseFirestore.instance;
    final results = await firestore.collection(collection).where('name', isEqualTo: query).get();
    var list = results.docs.map((doc) => fromMap(doc.data())).toList();
    return list.isEmpty ? [] : list;
  }

  Future<void> fetchSearchResults(String query) async {
      final sitesFuture = _fetchFromFirestore('sites', query, (data) => CustomContent(name: data['name'], imageUrl: data['imageUrl']));
      final productsFuture = _fetchFromFirestore('products', query, (data) => Product(name: data['name'], imageUrl: data['imageUrl'], id: '', price: null, quantity: null));
      
      final List<CustomContent> sites = await sitesFuture;
      final List<Product> products = await productsFuture;

      state = SearchResult(sites: sites, products: products);
  }

  Future<List<Post>> fetchPostsByCaption(String query) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('caption', isGreaterThanOrEqualTo: query)
        .where('caption', isLessThan: '$query\uf8ff')
        .get();

    return querySnapshot.docs.map((doc) => PostFirestore.fromFirestore(doc)).toList();
  }

  
  Future<List<Post>> fetchPostsByPrice(double minPrice, double maxPrice) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('price', isGreaterThanOrEqualTo: minPrice)
        .where('price', isLessThanOrEqualTo: maxPrice)
        .get();

    return querySnapshot.docs.map((doc) => PostFirestore.fromFirestore(doc)).toList();
  }
}


