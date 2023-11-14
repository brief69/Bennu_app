

// wallet_service.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:solana/solana.dart';

class Wallet {
  final Ed25519HDKeyPair keyPair;

  Wallet(this.keyPair);

  String get publicKey => keyPair.publicKey.toString();
  String get privateKey => keyPair.extract().toString();
}

class WalletService {
  final storage = const FlutterSecureStorage();

  // 新しいランダムなウォレットを生成する
  Future<Wallet> createRandomWallet() async {
    final keyPair = await Ed25519HDKeyPair.random();
    final wallet = Wallet(keyPair);

    // 秘密キーをflutter_secure_storageで保存
    await savePrivateKey(wallet.privateKey);

    return wallet;
  }

  // mnemonicからウォレットを生成する
  Future<Wallet> createWalletFromMnemonic(String mnemonic) async {
    final keyPair = await Ed25519HDKeyPair.fromMnemonic(mnemonic);
    return Wallet(keyPair);
  }

  // 秘密キーからウォレットを生成する
  Future<Wallet> createWalletFromPrivateKey(List<int> privateKey) async {
    final keyPair = await Ed25519HDKeyPair.fromPrivateKeyBytes(privateKey: privateKey);
    return Wallet(keyPair);
  }

  Future<void> savePrivateKey(String privateKey) async {
    await storage.write(key: 'solanaPrivateKey', value: privateKey);
  }

  Future<String?> getPrivateKey() async {
    return await storage.read(key: 'solanaPrivateKey');
  }
}

// 'package:solana/solana.dart': Solana関連の操作をサポートする外部ライブラリをインポートしています。
// 'package:flutter_secure_storage/flutter_secure_storage.dart': セキュアなストレージの操作に関連する機能を提供するライブラリ。

// Walletクラス:
// Ed25519HDKeyPair keyPair: Solanaウォレットのキーペアを表現します。
// publicKeyおよびprivateKey: キーペアから公開キーと秘密キーを取得するgetterメソッドです。
// 特に秘密キーはセキュリティの観点から注意が必要です。これがこのアプリで最も注意が必要な実装です!!!

// WalletServiceクラス:
// FlutterSecureStorage storage: セキュアなストレージを操作するためのインスタンスです。

// createRandomWalletメソッド:
// ランダムなキーペアを生成して、それを基に新しいWalletオブジェクトを作成します。
// 作成されたウォレットの秘密キーをセキュアなストレージに保存します。

// createWalletFromMnemonicメソッド:
// 与えられたmnemonic（ニーモニック、秘密のフレーズ）から、キーペアを生成してWalletオブジェクトを返します。

// createWalletFromPrivateKeyメソッド:
// 与えられた秘密キーから、キーペアを生成してWalletオブジェクトを返します。
// savePrivateKeyおよびgetPrivateKeyメソッド:
// ウォレットの秘密キーをセキュアなストレージに保存するか、取得するためのメソッドです。

// 全体のロジックとの関連性:
// このWalletServiceクラスは、Solanaのウォレットに関連する主要な操作をサポートしています。
// ユーザーが新しいウォレットを生成する場合や、既存のニーモニックや秘密キーからウォレットを再生する場合、このクラスのメソッドが使用されます。
// 特に、秘密キーはセキュアなストレージに保存され、必要に応じて取り出されることが強調されています。