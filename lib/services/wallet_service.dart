import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:solana/solana.dart';

class Wallet {
  final Ed25519HDKeyPair keyPair;

  // コンストラクタ
  Wallet(this.keyPair);

  // 公開キーを取得する
  String get publicKey => keyPair.publicKey.toString();
  // 秘密キーを取得する
  String get privateKey => keyPair.extract().toString();
}

// ウォレットサービスクラス
class WalletService {
  final storage = const FlutterSecureStorage();

  // 新しいランダムなウォレットを生成する関数
  Future<Wallet> createRandomWallet() async {
    final keyPair = await Ed25519HDKeyPair.random();
    final wallet = Wallet(keyPair);

    // 秘密キーをflutter_secure_storageで保存する
    await savePrivateKey(wallet.privateKey);

    return wallet;
  }

  // mnemonicからウォレットを生成する関数
  Future<Wallet> createWalletFromMnemonic(String mnemonic) async {
    final keyPair = await Ed25519HDKeyPair.fromMnemonic(mnemonic);
    return Wallet(keyPair);
  }

  // 秘密キーからウォレットを生成する関数
  Future<Wallet> createWalletFromPrivateKey(List<int> privateKey) async {
    final keyPair = await Ed25519HDKeyPair.fromPrivateKeyBytes(privateKey: privateKey);
    return Wallet(keyPair);
  }

  // 秘密キーを保存する関数
  Future<void> savePrivateKey(String privateKey) async {
    await storage.write(key: 'solanaPrivateKey', value: privateKey);
  }

  // 秘密キーを取得する関数
  Future<String?> getPrivateKey() async {
    return await storage.read(key: 'solanaPrivateKey');
  }
}
