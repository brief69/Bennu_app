

// token_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solana/solana.dart';
import '../models/berry_token.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> mintBerryToken(DocumentSnapshot<Map<String, dynamic>> post) async {
  const storage = FlutterSecureStorage();

  // 秘密キーの取得
  final privateKeyString = await storage.read(key: 'privateKey');
  if (privateKeyString == null) {
    throw Exception('Private key not found');
  }
  final privateKey = Ed25519HDPublicKey.fromBase58(privateKeyString); 

  final berryToken = BerryToken(
    address: Ed25519HDPublicKey.fromBase58('YourHardcodedPublicKey'), // (発行者の)公開鍵
    supply: BigInt.from(0), // トークンの初期供給量は 0
    decimals: 9, 
    mintAuthority: privateKey, 
    isInitialized: true,
    freezeAuthority: Ed25519HDPublicKey.fromBase58('YourHardcodedPublicKey'), 
  );

  final amountToMint = BigInt.from(3) * BigInt.from(10).pow(17); 

  // Firestoreからユーザーの公開キーを取得
  final userId = post.data()?['userId'];
  if (userId == null) {
    throw Exception('User ID not found in post');
  }
  final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
  final userAddressString = userDoc.data()?['publicKey'];
  if (userAddressString == null) {
    throw Exception('User public key not found');
  }
  final userAddress = Ed25519HDPublicKey.fromBase58(userAddressString);

  berryToken.mintToken(
    mintAuthority: privateKey,
    destination: userAddress, 
    amount: amountToMint
  );

  if (berryToken.supply + amountToMint > BigInt.from(33000000) * BigInt.from(10).pow(9)) {
    throw Exception('Token supply limit exceeded');
  }
}
