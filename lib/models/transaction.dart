// 取引を表すクラス
class Transaction {
  final String seller; // 売り手
  final String buyer; // 買い手
  final DateTime timestamp; // 取引のタイムスタンプ

  // コンストラクタ
  Transaction({
    required this.seller,
    required this.buyer,
    required this.timestamp,
  });

  // この取引をマップに変換するメソッド
  Map<String, dynamic> toMap() {
    return {
      'seller': seller, // 売り手
      'buyer': buyer, // 買い手
      'timestamp': timestamp, // 取引のタイムスタンプ
    };
  }

  // マップから取引を作成する静的メソッド
  static Transaction fromMap(Map<String, dynamic> map) {
    return Transaction(
      seller: map['seller'], // 売り手
      buyer: map['buyer'], // 買い手
      timestamp: map['timestamp'].toDate(), // 取引のタイムスタンプ
    );
  }
}
