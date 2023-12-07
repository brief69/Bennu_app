import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactViewModelProvider = ChangeNotifierProvider<ContactViewModel>((ref) => ContactViewModel());

class ContactViewModel extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final String twitterUrl = 'https://twitter.com/Bennu_app';

  Future<void> sendFeedback(String feedback) async {
    try {
      // Firestoreの`feedback`コレクションに新しいドキュメントを追加します
      await _firebaseFirestore.collection('feedback').add({
        'text': feedback,
        'timestamp': Timestamp.now(),
        // 他の必要なフィールドもここに追加できます
      });
      // 成功した場合の処理（ここでは通知の更新）
      notifyListeners();
    } catch (e) {
      // エラーハンドリング（適切なエラーメッセージの表示やログの記録など）
    }
  }

  void contactViaTwitter() async {
    // ignore: deprecated_member_use
    if (await canLaunch(twitterUrl)) {
      // ignore: deprecated_member_use
      await launch(twitterUrl);
    } else {
      // エラーハンドリング（適切なエラーメッセージの表示やログの記録など）
    }
  }
}

