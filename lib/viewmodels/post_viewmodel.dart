

import 'dart:io';
import 'package:bennu_app/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bennu_app/services/firestore_service.dart';

import '../models/currency.dart';

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
  final Reader read;

  PostViewModel(this.read) : super(const AsyncValue.loading());

  get uploadMediaAndCaption => null;

  // StorageへのビデオのアップロードとFirestoreへの投稿データの保存
  Future<void> uploadMediaAndCaptio(File videoFile, String userId, String caption, double price, int stock, Currency currency) async {
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
        price: price,
        stock: stock,
        currency: currency,
      );

      // 省略: fetchVideosメソッドなど他のメソッド
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }
}
