

// logout_model.dart
import 'package:firebase_auth/firebase_auth.dart';

class LogoutModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> performLogout() async {
    await _auth.signOut();
  }
}
