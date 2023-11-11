

// user_media_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/media_model.dart';

final userPostsProvider = Provider<List<MediaModel>>((ref) {
  // Firestoreからユーザーの投稿履歴データを取得するロジック
});

final userLikesProvider = Provider<List<MediaModel>>((ref) {
  // Firestoreからユーザーのいいね履歴データを取得するロジック
});

final userBuysProvider = Provider<List<MediaModel>>((ref) {
  // Firestoreからユーザーの購入履歴データを取得するロジック
});
