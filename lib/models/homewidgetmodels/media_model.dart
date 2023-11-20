

// media_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class MediaModel {
  final String videoUrl;
  final String userIcon;
  final int likes;
  final int comments;
  final String other;
  final int buy;
  final int incart;
  final int shares;
  final String caption;
  final int stock;
  final int price;
  final int relay;
  final String postId;
  final String userId;

  MediaModel({
    required this.videoUrl,
    required this.userIcon,
    required this.likes,
    required this.comments,
    required this.other,
    required this.buy,
    required this.incart,
    required this.shares,
    required this.caption,
    required this.stock,
    required this.price,
    required this.relay,
    required this.postId,
    required this.userId, required FirebaseFirestore firestore, required mediaItems,
  });

  get mediaItems => null;

  // copyWith メソッドの修正
  MediaModel copyWith({
    String? videoUrl,
    String? userIcon,
    int? likes,
    int? comments,
    String? other,
    int? buy,
    int? incart,
    int? shares,
    String? caption,
    int? stock,
    int? price,
    int? relay,
    String? postId,
    String? userId, required int quantity,
  }) {
    return MediaModel(
      videoUrl: videoUrl ?? this.videoUrl,
      userIcon: userIcon ?? this.userIcon,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      other: other ?? this.other,
      buy: buy ?? this.buy,
      incart: incart ?? this.incart,
      shares: shares ?? this.shares,
      caption: caption ?? this.caption,
      stock: stock ?? this.stock,
      price: price ?? this.price,
      relay: relay ?? this.relay,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      firestore: FirebaseFirestore.instance, mediaItems: null,
    );
  }

  // fromMap 静的メソッドの修正
  static MediaModel fromMap(Map<String, dynamic> data) {
    return MediaModel(
      videoUrl: data['videoUrl'],
      userIcon: data['userIcon'],
      likes: data['likes'],
      comments: data['comments'],
      other: data['other'],
      buy: data['buy'],
      incart: data['incart'],
      shares: data['shares'],
      caption: data['caption'],
      stock: data['stock'],
      price: data['price'],
      relay: data['relay'],
      postId: data['postId'],
      userId: data['userId'],
      firestore: FirebaseFirestore.instance, mediaItems: null,
    );
  }
}
