import 'package:solana/solana.dart';

class BerryToken {
  final Ed25519HDPublicKey address;
  late final BigInt supply;
  final int decimals;
  final Ed25519HDPublicKey? mintAuthority;
  final bool isInitialized;
  final Ed25519HDPublicKey? freezeAuthority;

  BerryToken({
    required this.address,
    required this.supply,
    required this.decimals,
    this.mintAuthority,
    required this.isInitialized,
    this.freezeAuthority,
  });

  factory BerryToken.createMint({
    required Ed25519HDPublicKey address,
    required int decimals,
    required Ed25519HDPublicKey? mintAuthority,
  }) {
    return BerryToken(
      address: address,
      supply: BigInt.zero,
      decimals: decimals,
      mintAuthority: mintAuthority,
      isInitialized: false,
      freezeAuthority: null,
    );
  }

  void mintToken({
    required Ed25519HDPublicKey mintAuthority,
    required Ed25519HDPublicKey destination,
    required BigInt amount,
  }) {
    if (this.mintAuthority == null) {
      throw Exception('Mint authority is not set');
    }
    if (this.mintAuthority != mintAuthority) {
      throw Exception('Invalid mint authority');
    }
    if (!isInitialized) {
      throw Exception('Token is not initialized');
    }
    if (freezeAuthority != null) {
      throw Exception('Token is frozen');
    }
    supply += amount;
  }
}