


// profile_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  User? get user => _user;

  get qrImageData => null;

  void get username {}

  String? get userIcon => null;

  get followingCount => null;

  // ユーザーデータをロード
  Future<void> loadUserData(String userId) async {
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      _user = User.fromDocument(doc);
      notifyListeners();
  }

  // ユーザーアイコンを更新
  Future<void> updateUserIcon(String userId, String newIconUrl) async {
      await _firestore.collection('users').doc(userId).update({
        'userIcon': newIconUrl,
      });
      _user?.userIcon = newIconUrl;
      notifyListeners();
  }

   Future<void> fetchQRCodeFromFirestore(String userId) async {
      // userIdを元にFirestoreのusersコレクションからユーザーのデータを取得
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        // Firestoreから取得したデータの中からQRコードのデータを取り出す
        // データ構造に応じて適切なキー名を指定する
        Uint8List? fetchedData = userDoc.data()?['qrImageData'] as Uint8List?;
      }
   }

  // Solanaアドレスをコピー
  String get solanaAddress => _user?.solanaAddress ?? '';
}