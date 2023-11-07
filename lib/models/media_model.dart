

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
    required this.price, required FirebaseFirestore firestore,
    required this.relay,
  });

  get postDate => null;

  get itemlimit => null;

  get mediaItems => null;
}
