

// user_media_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/media_model.dart';
import '../services/firestore_service.dart';
import 'user_manager.dart';


// FirestoreServiceのインスタンスを作成
final firestoreService = FirestoreService();
final userLikesProvider = FutureProvider<List<MediaModel>>((ref) async {
  // 現在のユーザー情報を取得
  final currentUser = ref.watch(currentUserProvider)?.state;
  
  // ユーザーIDを取得してメソッドに渡す
  if (currentUser != null) {
    return await firestoreService.fetchUserLikes(currentUser.id);
  } else {
    return []; // ユーザーがログインしていない場合は空のリストを返す
  }
});

final userBuysProvider = FutureProvider<List<MediaModel>>((ref) async {
  // 現在のユーザー情報を取得
  final currentUser = ref.watch(currentUserProvider)?.state;
  
  // ユーザーIDを取得してメソッドに渡す
  if (currentUser != null) {
    return await firestoreService.fetchUserBuys(currentUser.id);
  } else {
    return []; // ユーザーがログインしていない場合は空のリストを返す
  }
});