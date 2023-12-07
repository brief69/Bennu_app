import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// プロフィール画面のビューモデル
class ProfileViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestoreのインスタンス

  User? _user; // ユーザーデータ
  User? get user => _user; // ユーザーデータのゲッター
  get qrImageData => null; // QRコードのデータ（未実装）
  String? get userIcon => _user?.userIcon; // ユーザーアイコンのURL
  String get username => _user?.userName ?? ''; // ユーザー名
  get followingCount => null; // フォロー数（未実装）
  get profile => null; // プロフィール（未実装）
  get followersCount => null; // フォロワー数（未実装）
 

  // ユーザーデータをロードするメソッド
  Future<void> loadUserData(String userId) async {
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get(); // Firestoreからユーザーデータを取得
      _user = User.fromDocument(doc); // ユーザーデータをモデルに変換
      notifyListeners(); // 状態の更新を通知
  }

  // ユーザーアイコンを更新するメソッド
  Future<void> updateUserIcon(String userId, String newIconUrl) async {
      await _firestore.collection('users').doc(userId).update({ // Firestoreのユーザーデータを更新
        'userIcon': newIconUrl,
      });
      _user?.userIcon = newIconUrl; // ローカルのユーザーデータを更新
      notifyListeners(); // 状態の更新を通知
  }
  // ユーザー名を更新するメソッド
  void updateUsername(String newName) {
    if (_user != null) {
      _user!.userName = newName; // ローカルのユーザーデータを更新
      notifyListeners(); // 状態の更新を通知
    }
  }
   // QRコードを取得するメソッド（未実装）
  Future<void> fetchQRCodeFromFirestore(String userId) async {
  DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get(); // Firestoreからユーザーデータを取得

    if (userDoc.exists) {
    }
  }

  // Solanaアドレスを取得するメソッド
  String get solanaAddress => _user?.solanaAddress ?? '';


  // プロフィールの変更をFirestoreに保存するメソッド
  Future<void> saveProfileChanges() async {
    if (_user != null) {
      await _firestore.collection('users').doc(_user!.id).update({ // Firestoreのユーザーデータを更新
        'name': _user!.name,
        // 他に更新するフィールドがあればここに追加
      });
      notifyListeners(); // 状態の更新を通知
    }
  }

  pickUserIcon() {} // ユーザーアイコンを選択するメソッド（未実装）

  goToQRPage() {} // QRコードページに遷移するメソッド（未実装）

  copySolanaAddress() {} // Solanaアドレスをコピーするメソッド（未実装）
}
