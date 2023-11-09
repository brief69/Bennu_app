

// firestore_service.dart
import 'package:bennu_app/models/widgetmodels/comments.dart';
import 'package:bennu_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _usersCollection = FirebaseFirestore.instance.collection('users');

  Future<void> storeUser(User user) async {
    await _usersCollection.doc(user.id).set({
      'email': user.email,
      'publicKey': user.publicKey,
    });
  }
}


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
