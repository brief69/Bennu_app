

// post.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String userIcon;
  final String caption;
  final DateTime postDate;
  final int likesCount;
  final int commentsCount;
  final int buyCount;
  final int inCart;
  final int shareCount;
  final List<String> mediaUrls;
  final double price;
  final int stock;
  final int relayCount;
  final String originalSeller;
  late final String currentSeller;
  final List<Transaction> transactionHistory;

  Post( {
    required this.userIcon,
    required this.caption,
    required this.postDate,
    required this.likesCount,
    required this.commentsCount,
    required this.buyCount,
    required this.inCart,
    required this.shareCount,
    required this.mediaUrls,
    required this.price,
    required this.stock,
    required this.relayCount,
    required this.originalSeller,
    required this.currentSeller,
    required this.transactionHistory,
  });

  Map<String, dynamic> toMap() {
    return {
      'caption': caption,
      'commentsCount': commentsCount,
      'likesCount': likesCount,
      'mediaUrls': mediaUrls,
      'postDate': postDate,
      'buyCount': buyCount,
      'inCart': inCart,
      'shareCount': shareCount,
      'userIcon': userIcon,
      'price': price,
      'stock': stock,
      'relayCount': relayCount,
      'originalSeller': originalSeller,
      'currentSeller': currentSeller,
      'transactionHistory': transactionHistory,
    };
  }

  static Post fromMap(Map<String, dynamic> map) {
    return Post(
      caption: map['caption'],
      commentsCount: map['commentsCount'],
      likesCount: map['likesCount'],
      mediaUrls: List<String>.from(map['mediaUrls']),
      postDate: map['postDate'],
      buyCount: map['buyCount'],
      inCart: map['inCart'],
      shareCount: map['shareCount'],
      userIcon: map['userIcon'],
      price: map['price'],
      stock: map['stock'],
      relayCount: map['relayCount'],
      originalSeller: map['originalSeller'],
      currentSeller: map['currentSeller'],
      transactionHistory: map['transactionHistory'],
    );
  }

  static fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> doc) {}
}


extension PostFirestore on Post {
  static Post fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Post(
      userIcon: data['userIcon'] ?? '',
      caption: data['caption'] ?? '',
      postDate: (data['postDate'] as Timestamp).toDate(),
      likesCount: data['likesCount'] ?? 0,
      commentsCount: data['commentsCount'] ?? 0,
      buyCount: data['buyCount'] ?? 0,
      inCart: data['inCart'],
      shareCount: data['shareCount'] ?? 0,
      mediaUrls: List<String>.from(data['mediaUrls'] ?? []),
      price: data['price'] ?? 0,
      stock: data['stock'] ?? 0,
      relayCount: data['relayCount'] ?? 0,
      originalSeller: data['originalSeller'],
      currentSeller: data['currentSeller'],
      transactionHistory: data['transactionHistory'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userIcon': userIcon,
      'caption': caption,
      'postDate': postDate,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'buyCount': buyCount,
      'inCart': inCart,
      'shareCount': shareCount,
      'mediaUrls': mediaUrls,
      'price': price,
      'stock': stock,
      'relayCount': relayCount,
      'originalSeller': originalSeller,
      'currentSeller': currentSeller,
      'transactionHistory': transactionHistory,
    };
  }
}

