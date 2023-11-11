


// profile_viewmodel.dart
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  User? get user => _user;
  get qrImageData => null;
  String? get userIcon => _user?.userIcon;
  String get username => _user?.userName ?? '';
  get followingCount => null;
  get profile => null;
  get followersCount => null;
 

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
  // ユーザー名を更新するためのメソッド
  void updateUsername(String newName) {
    if (_user != null) {
      _user!.userName = newName;
      // ローカルの状態を更新
      notifyListeners();
    }
  }
   // QRコードを取得（実装が必要）
  Future<void> fetchQRCodeFromFirestore(String userId) async {
  DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();

    if (userDoc.exists) {
      // ふむう、、
    }
  }

  // Solanaアドレスをコピー
  String get solanaAddress => _user?.solanaAddress ?? '';


  // プロフィールの変更をFirestoreに保存するためのメソッド
  Future<void> saveProfileChanges() async {
    if (_user != null) {
      await _firestore.collection('users').doc(_user!.id).update({
        'name': _user!.name,
        // 他に更新するフィールドがあればここに追加
      });
      // ローカルの状態を更新
      notifyListeners();
    }
  }

  pickUserIcon() {}

  goToQRPage() {}

  copySolanaAddress() {}
}

// ProfileViewModel の役割
// ProfileViewModel は、特定のユーザーのプロフィールに関連するデータと操作に焦点を当てます。
// これには以下が含まれます：

// ユーザープロフィールのデータのロード
// ユーザーのアイコンやその他のプロフィール情報の更新
// ユーザーのフォロワー数やフォロー数の表示
// ProfileViewModel は、特定のユーザー
// （現在ログインしているユーザーかもしれませんが、他のユーザーのプロフィールを表示する場合もある）
// のプロフィールデータを扱います。

