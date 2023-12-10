import 'package:bennu/auth/relying_party_server.dart';
import 'package:passkeys/passkey_auth.dart';

class AuthService { // AuthServiceクラス
  BennuRelyingPartyServer? server; // BennuRelyingPartyServerのインスタンスを作成
  PasskeyAuth? _auth; // PasskeyAuthのインスタンスを作成

  AuthService() {
    server = BennuRelyingPartyServer.createInstance();
    if (server != null) {
      _auth = PasskeyAuth(server!);
    } else {
      throw Exception('サーバーのインスタンスがnullです');
    }
  }

  registerUserWithEmail(String email) {
    _auth?.registerWithEmail(email);
  }
}
  