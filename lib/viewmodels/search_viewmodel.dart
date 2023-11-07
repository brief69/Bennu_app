


// search_viewmodel.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/search_model.dart';

final searchProvider = StateNotifierProvider<SearchViewModel, SearchResult>((ref) => SearchViewModel());

class SearchViewModel extends StateNotifier<SearchResult> {
  SearchViewModel() : super(SearchResult(sites: [], products: []));

  final TextEditingController searchController = TextEditingController();

  Future<List<T>> _fetchFromFirestore<T>(String collection, String query, T Function(Map<String, dynamic>) fromMap) async {
    final firestore = FirebaseFirestore.instance;
    final results = await firestore.collection(collection).where('name', isEqualTo: query).get();
    return results.docs.map((doc) => fromMap(doc.data())).toList();
  }

  Future<void> fetchSearchResults(String query) async {
    try {
      final sitesFuture = _fetchFromFirestore('sites', query, (data) => CustomContent(name: data['name'], imageUrl: data['imageUrl']));
      final productsFuture = _fetchFromFirestore('products', query, (data) => Product(name: data['name'], imageUrl: data['imageUrl'], id: '', price: null, quantity: null));
      
      final List<CustomContent> sites = await sitesFuture;
      final List<Product> products = await productsFuture;

      state = SearchResult(sites: sites, products: products);
    } catch (e) {
      // TODO: Handle the error appropriately, e.g. by updating the state to reflect the error
    }
  }
}
