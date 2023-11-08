

// auth_service.dart
import 'package:passkeys/passkey_auth.dart';
import 'package:passkeys/relying_party_server/relying_party_server.dart';

class AuthService {
  final PasskeyAuth _auth = PasskeyAuth(RelyingPartyServer as RelyingPartyServer);

  Future<String?> registerWithEmail(String email) async {
    final response = await _auth.registerWithEmail(email);
    if (response != null) {
      return response.userId;
    }
    return null;
  }
}
