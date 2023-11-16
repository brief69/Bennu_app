

// firestore_service.dart
import 'package:bennu_app/models/homewidgetmodels/comments.dart';
import 'package:bennu_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/currency.dart';
import '../models/homewidgetmodels/media_model.dart';

class FirestoreService {
  final _usersCollection = FirebaseFirestore.instance.collection('users');
  
  get db => '';
  
  get caption => null;

  Future<void> storeUser(User user) async {
    await _usersCollection.doc(user.id).set({
      'email': user.email,
      'publicKey': user.publicKey,
    });
  }

  Future<void> createPost({
    required String userId,
    required String videoUrl,
    required String caption,
    required double price,
    required int stock,
    required Currency currency,
     // その他必要なデータを引数として追加
  }) async {
    final post = {
      'userId': userId,
      'videoUrl': videoUrl,
      'caption': caption,
      'price': price,
      'stock': stock,
      'currency': currency.toString(),
      'timestamp': FieldValue.serverTimestamp(), // Use server timestamp
      // その他のフィールドを追加
    };
    await db.collection('posts').add(post);
  }

  fetchUserLikes(id) {}

  fetchUserBuys(id) {}
}

// comments
Future<List<Comment>> fetchComments(String videoID) async {
  final commentsCollection = FirebaseFirestore.instance.collection('videos').doc(videoID).collection('comments');
  final snapshot = await commentsCollection.orderBy('timestamp', descending: true).get();

  return snapshot.docs.map((doc) => Comment(
    username: doc['username'],
    content: doc['content'],
    timestamp: (doc['timestamp'] as Timestamp).toDate(),
    likes: doc['likes'],
    dislikes: doc['dislikes'],
  )).toList();
}

Future<void> addComment(String videoID, Comment comment) async {
  final commentsCollection = FirebaseFirestore.instance.collection('videos').doc(videoID).collection('comments');
  await commentsCollection.add({
    'username': comment.username,
    'content': comment.content,
    'timestamp': FieldValue.serverTimestamp(),
    'likes': 0,
    'dislikes': 0,
  });
}
Future<void> updateLikes(String videoID, String commentID, int newLikes) async {
  final commentDoc = FirebaseFirestore.instance.collection('videos').doc(videoID).collection('comments').doc(commentID);
  await commentDoc.update({'likes': newLikes});
}

Future<void> updateDislikes(String videoID, String commentID, int newDislikes) async {
  final commentDoc = FirebaseFirestore.instance.collection('videos').doc(videoID).collection('comments').doc(commentID);
  await commentDoc.update({'dislikes': newDislikes});
}

// profile history
Future<List> fetchUserPosts(String userId) async {
    final userPostsCollection = FirebaseFirestore.instance.collection('posts');
    final snapshot = await userPostsCollection.where('userId', isEqualTo: userId).get();

    return snapshot.docs.map((doc) => MediaModel.fromMap(doc.data())).toList();
  }

  Future<List> fetchUserLikes(String userId) async {
    final userLikesCollection = FirebaseFirestore.instance.collection('likes');
    final snapshot = await userLikesCollection.where('userId', isEqualTo: userId).get();

    return snapshot.docs.map((doc) => MediaModel.fromMap(doc.data())).toList();
  }

  Future<List> fetchUserBuys(String userId) async {
    final userBuysCollection = FirebaseFirestore.instance.collection('purchases');
    final snapshot = await userBuysCollection.where('userId', isEqualTo: userId).get();

    return snapshot.docs.map((doc) => MediaModel.fromMap(doc.data())).toList();
  }

