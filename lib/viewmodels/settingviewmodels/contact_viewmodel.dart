

// contact_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void contactViaTwitter() {
    // ignore: deprecated_member_use
    canLaunch(twitterUrl).then((canLaunchUrl) {
      if (canLaunchUrl) {
        // ignore: deprecated_member_use
        launch(twitterUrl);
      } else {
      }
    });
  }
}
