import 'dart:io';
import 'package:bennu/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bennu/services/firestore_service.dart';


final postViewModelProvider = StateNotifierProvider<PostViewModel, AsyncValue<List<Post>>>((ref) {
  return PostViewModel(ref.read);
});

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final storageProvider = Provider<FirebaseStorage>((ref) {
  return FirebaseStorage.instance;
});

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});

class PostViewModel extends StateNotifier<AsyncValue<List<Post>>> {
  // ignore: deprecated_member_use
  final Reader read;

  PostViewModel(this.read) : super(const AsyncValue.loading());

  // StorageへのビデオのアップロードとFirestoreへの投稿データの保存
  Future<void> uploadMediaAndCaption(File videoFile, String userId, String caption, num price, int stock, bool isPriceInBerry) async {
    try {
      final ref = read(storageProvider).ref().child('videos/${videoFile.path}');
      await ref.putFile(videoFile);
      final downloadUrl = await ref.getDownloadURL();

      // FirestoreServiceを使用してビデオのURLと投稿データを保存
      final firestoreService = read(firestoreServiceProvider);
      await firestoreService.createPost(
        userId: userId,
        videoUrl: downloadUrl,
        caption: caption,
        price: price.toDouble(),
        stock: stock,
        isPriceInBerry: isPriceInBerry,
      );

      // 省略: fetchVideosメソッドなど他のメソッド
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  repost({required String caption, required double price, required int stock, required String changeNotes}) {}
}
