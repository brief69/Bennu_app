

// user.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  late final String userIcon;
  late final String userName;
  final String solanaAddress;
  final List<dynamic> postHistory;
  final List<dynamic> likesHistory;
  final List<dynamic> buyHistory;
  final int followingCount;
  final int followerCount;

  User({
    required this.id,
    required this.userName,
    required this.userIcon,
    required this.solanaAddress,
    required this.postHistory,
    required this.likesHistory,
    required this.buyHistory,
    required this.followingCount,
    required this.followerCount,
  });

  // FirestoreのDocumentSnapshotからUserモデルに変換するためのファクトリメソッド
  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      userName: doc['userName'],
      userIcon: doc['userIcon'],
      solanaAddress: doc['solanaAddress'],
      postHistory: List<dynamic>.from(doc['postHistory']),
      likesHistory: List<dynamic>.from(doc['likesHistory']),
      buyHistory: List<dynamic>.from(doc['buyHistory']),
      followingCount: doc['followingCount'] ?? 0,
      followerCount: doc['followerCount'] ?? 0,
    );
  }

  get email => null;

  get publicKey => null;

  get name => null;

  get state => null;

  // ... other properties and methods ...

  Future<bool> deleteCurrentUser() async {
    // implementation to delete the current user
    return true; // return true if the deletion was successful
  }
}
