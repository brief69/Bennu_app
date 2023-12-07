import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/homewidgetmodels/media_model.dart';
import '/models/user.dart';

// Firestoreサービスクラス
class FirestoreService {
  // ユーザーコレクションへの参照
  final _usersCollection = FirebaseFirestore.instance.collection('users');
  
  // データベースへの参照（未定義）
  get db => '';
  
  // キャプションへの参照（未定義）
  get caption => null;

  // ユーザー情報をFirestoreに保存する関数
  Future<void> storeUser(User user) async {
    await _usersCollection.doc(user.id).set({
      'email': user.email,
      'publicKey': user.publicKey,
    });
  }

  // 新しい投稿をFirestoreに保存する関数
  Future<void> createPost({
    required String userId,
    required String videoUrl,
    required String caption,
    required double price,
    required int stock,
    required bool isPriceInBerry,
  }) async {
    final post = {
      'userId': userId,
      'videoUrl': videoUrl,
      'caption': caption,
      'price': price,
      'stock': stock,
      'isPriceInBerry': isPriceInBerry,
      'timestamp': FieldValue.serverTimestamp(), // サーバータイムスタンプを使用
      // その他のフィールドを追加
    };
    await db.collection('posts').add(post);
  }

  // ユーザーの「いいね」を取得する関数（未定義）
  fetchUserLikes(id) {}

  // ユーザーの購入を取得する関数（未定義）
  fetchUserBuys(id) {}
}


// // プロフィール履歴関連の関数 // //
// ユーザーの投稿を取得する関数
Future<List> fetchUserPosts(String userId) async {
    final userPostsCollection = FirebaseFirestore.instance.collection('posts');
    final snapshot = await userPostsCollection.where('userId', isEqualTo: userId).get();

    return snapshot.docs.map((doc) => MediaModel.fromMap(doc.data())).toList();
  }

  // ユーザーの「いいね」を取得する関数
  Future<List> fetchUserLikes(String userId) async {
    final userLikesCollection = FirebaseFirestore.instance.collection('likes');
    final snapshot = await userLikesCollection.where('userId', isEqualTo: userId).get();

    return snapshot.docs.map((doc) => MediaModel.fromMap(doc.data())).toList();
  }

  // ユーザーの購入を取得する関数
  Future<List> fetchUserBuys(String userId) async {
    final userBuysCollection = FirebaseFirestore.instance.collection('purchases');
    final snapshot = await userBuysCollection.where('userId', isEqualTo: userId).get();

    return snapshot.docs.map((doc) => MediaModel.fromMap(doc.data())).toList();
  }

