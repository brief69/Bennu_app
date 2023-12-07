import 'package:firebase_auth/firebase_auth.dart';

// ログアウトモデルクラス
class LogoutModel {
  // FirebaseAuthのインスタンスを作成
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ログアウトを実行するメソッド
  Future<void> performLogout() async {
    // FirebaseAuthからサインアウト
    await _auth.signOut();
  }
}
