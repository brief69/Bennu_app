

// transaction.dart
class Transaction {
  final String seller;
  final String buyer;
  final DateTime timestamp;

  Transaction({
    required this.seller,
    required this.buyer,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'seller': seller,
      'buyer': buyer,
      'timestamp': timestamp,
    };
  }

  static Transaction fromMap(Map<String, dynamic> map) {
    return Transaction(
      seller: map['seller'],
      buyer: map['buyer'],
      timestamp: map['timestamp'].toDate(),
    );
  }
}
