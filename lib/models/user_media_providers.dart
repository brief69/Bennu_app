

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/firestore_service.dart';
import 'media_model.dart';


// FirestoreServiceのインスタンスを作成
final firestoreService = FirestoreService();

final userPostsProvider = Provider<List<MediaModel>>((ref) async {
  // Firestoreからユーザーの投稿履歴データを取得
  List<MediaModel> userPosts = await firestoreService.fetchUserPosts(/* ユーザーIDを渡す */);
  return userPosts;
} as Create<List<MediaModel>, ProviderRef<List<MediaModel>>>);

final userLikesProvider = Provider<List<MediaModel>>((ref) async {
  // Firestoreからユーザーのいいね履歴データを取得
  List<MediaModel> userLikes = await firestoreService.fetchUserLikes(/* ユーザーIDを渡す */);
  return userLikes;
} as Create<List<MediaModel>, ProviderRef<List<MediaModel>>>);

final userBuysProvider = Provider<List<MediaModel>>((ref) async {
  // Firestoreからユーザーの購入履歴データを取得
  List<MediaModel> userBuys = await firestoreService.fetchUserBuys(/* ユーザーIDを渡す */);
  return userBuys;
} as Create<List<MediaModel>, ProviderRef<List<MediaModel>>>);
