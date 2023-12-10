import 'package:http/http.dart';
import 'package:passkeys/relying_party_server/relying_party_server.dart';
import 'package:passkeys/relying_party_server/types/authentication.dart';
import 'package:passkeys/relying_party_server/types/registration.dart';

abstract class BennuRelyingPartyServer implements RelyingPartyServer {
  late final RelyingPartyServer _client;
  
  static get server => null;
  // 必要なメソッドを実装します
  // ...

  @override
  Future<Response> completeAuthenticate(AuthenticationCompleteRequest request) {
    // バックエンド（そしてクライアント）が期待するリクエストを構築します
    var apiRequest = YouApiClientAuthenticateRequest();
    
    // 信頼できるパーティーサーバーにcompleteAuthenticate呼び出しを行います
    var response = _client.completeAuthenticate(apiRequest as AuthenticationCompleteRequest);
    
    // バックエンドのレスポンスをResponseクラスにマッピングします
    return response.then((value) => Response(value.statusCode, value.body));
  }

  // ignore: body_might_complete_normally_nullable
  static BennuRelyingPartyServer? createInstance() {
    if (server == null) {
  // エラーハンドリングを行うか、nullを返さないように修正
}
  }
  }
  
  class YouApiClientAuthenticateRequest {
  }

  @override
  Future<Response> completeRegister(RegistrationCompleteRequest request) {
    // ここに具体的な実装を書く
    throw UnimplementedError();
  }

  @override
  Future<AuthenticationInitResponse> initAuthenticate(Request request) {
    // ここに具体的な実装を書く
    throw UnimplementedError();
  }

  @override
  Future<RegistrationInitResponse> initRegister(Request request) {
    // ここに具体的な実装を書く
    // ここに具体的な実装を書く
    // 未実装のエラーを投げる
    throw UnimplementedError('initRegisterメソッドはまだ実装されていません');
  }
