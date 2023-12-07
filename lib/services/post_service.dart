import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/post.dart';

// Firestoreから全ての投稿を取得する関数
Future<List<Post>> fetchPosts() async {
  final postRef = FirebaseFirestore.instance.collection('posts');
  final snapshot = await postRef.get();

  // 取得した投稿をPostオブジェクトのリストに変換
  return snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
}

// フォローしているユーザーの投稿だけをフィルタリングする関数
List<Post> filterForFollowing(List<Post> allPosts, List<String> followingUserIds) {
  return allPosts.where((post) => followingUserIds.contains(post.userId)).toList();
}