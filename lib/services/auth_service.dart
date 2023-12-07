import 'package:passkeys/passkey_auth.dart';
import 'package:passkeys/relying_party_server/relying_party_server.dart';

class AuthService { // AuthServiceクラス
  final PasskeyAuth _auth = PasskeyAuth(RelyingPartyServer as RelyingPartyServer); // PasskeyAuthのインスタンスを作成

  Future<String?> registerWithEmail(String email) async { // メールで登録するメソッド
    final response = await _auth.registerWithEmail(email); // メールで登録し、レスポンスを取得
    if (response != null) { // レスポンスがnullでない場合
      return response.userId; // ユーザーIDを返す
    }
    return null; // nullを返す
  }
}
