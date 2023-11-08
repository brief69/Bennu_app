


// registration_viewmodel.dart
import 'package:dms/services/auth_service.dart';
import 'package:dms/services/firestore_service.dart';
import 'package:dms/services/wallet_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class RegistrationViewModel {
  final AuthService _authService = AuthService();
  final WalletService _walletService = WalletService();
  final FirestoreService firestoreService = FirestoreService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final storage = FlutterSecureStorage();
  
  Future<void> registerAndCreateWallet(String email) async {
    try {
      final userId = await _authService.registerWithEmail(email);

      if (userId != null) {
        final wallet = await _walletService.createRandomWallet();
        // Use flutter_secure_storage to store the private key securely
        await storage.write(key: 'privateKey_$userId', value: wallet.privateKey);

        // Firestore transaction to store user details
        await _firestore.runTransaction((transaction) async {
          final userRef = _firestore.collection('users').doc(userId);
          final walletRef = _firestore.collection('wallets').doc(userId);

          transaction.set(userRef, {
            'id': userId,
            'email': email,
            'publicKey': wallet.publicKey,
            // other User information...
          });

          transaction.set(walletRef, {
            'publicKey': wallet.publicKey,
            // other Wallet information...
          });
        });
      }
    } catch (e) {
      ("Error during registration and wallet creation: $e");
    }
  }
}
