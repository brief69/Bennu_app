// ビデオIDに基づいてコメントを取得する関数
import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/homewidgetmodels/comments.dart';

Future<List<Comment>> fetchComments(String videoID) async {
  final commentsCollection = FirebaseFirestore.instance.collection('videos').doc(videoID).collection('comments');
  final snapshot = await commentsCollection.orderBy('timestamp', descending: true).get();

  return snapshot.docs.map((doc) => Comment(
    username: doc['username'],
    userIcon: doc['userIcon'],
    content: doc['content'],
    timestamp: (doc['timestamp'] as Timestamp).toDate(),
    likes: doc['likes'],
    dislikes: doc['dislikes'],
  )).toList();
}
// コメントを追加する関数
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
// コメントに対する「いいね」の数を更新する関数
Future<void> updateLikes(String videoID, String commentID, int newLikes) async {
  final commentDoc = FirebaseFirestore.instance.collection('videos').doc(videoID).collection('comments').doc(commentID);
  await commentDoc.update({'likes': newLikes});
}

// コメントに対する「嫌い」の数を更新する関数
Future<void> updateDislikes(String videoID, String commentID, int newDislikes) async {
  final commentDoc = FirebaseFirestore.instance.collection('videos').doc(videoID).collection('comments').doc(commentID);
  await commentDoc.update({'dislikes': newDislikes});
}