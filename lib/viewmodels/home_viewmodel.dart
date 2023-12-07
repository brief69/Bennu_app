import 'package:bennu/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'media_viewmodel.dart';

class MediaViewModelNotifier extends StateNotifier<List<MediaViewModel>> {
  MediaViewModelNotifier() : super([]);

  Future<void> fetchRecommendedPosts() async {
    // おすすめ投稿を取得して状態を更新
  }

  Future<void> fetchFollowedPosts() async {
    // フォロー中の投稿を取得して状態を更新
  }
}

final mediaViewModelProvider = StateNotifierProvider<MediaViewModelNotifier, List<MediaViewModel>>(
  (ref) => MediaViewModelNotifier(),
);

// lib/viewmodels/home_viewmodel.dart
class HomeViewModel {
  final FirestoreService postService;

  HomeViewModel({required this.postService});

  Future<void> fetchPosts() async {
    // Firestoreからのページネーションの例
    final postRef = FirebaseFirestore.instance.collection('posts').orderBy('timestamp').limit(10);
    await postRef.get();
    // 次のページを取得するとき
  }
}
