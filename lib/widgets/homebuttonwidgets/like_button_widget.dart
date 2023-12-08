import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LikeButtonWidget extends StatefulWidget { // StatefulWidgetを継承したLikeButtonWidgetクラスを定義します。
  final String postId; // 投稿IDを保持するフィールドを定義します。
  final String userId; // ユーザーIDを保持するフィールドを定義します。

  const LikeButtonWidget({Key? key, required this.postId, required this.userId}) : super(key: key); // コンストラクタを定義します。

  @override
  LikeButtonWidgetState createState() => LikeButtonWidgetState(); // 状態を管理するクラスを作成します。
}

class LikeButtonWidgetState extends State<LikeButtonWidget> { // LikeButtonWidgetの状態を管理するクラスを定義します。
  late bool _isLiked; // ユーザーが投稿を「いいね」したかどうかを保持するフィールドを定義します。

  @override
  void initState() { // 初期化メソッドを定義します。
    super.initState();
    _checkIfUserLikedPost(); // ユーザーが投稿を「いいね」したかどうかをチェックします。
  }

void _checkIfUserLikedPost() async { // ユーザーが投稿を「いいね」したかどうかをチェックするメソッドを定義します。
  DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(widget.userId).get(); // ユーザーのドキュメントを取得します。
  Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>; // ユーザーのデータを取得します。
  List likedPosts = userData['likedPosts'] ?? []; // ユーザーが「いいね」した投稿のリストを取得します。
  setState(() {
    _isLiked = likedPosts.contains(widget.postId); // ユーザーがこの投稿を「いいね」したかどうかを設定します。
  });
}

void _toggleLike() async { // 「いいね」の状態を切り替えるメソッドを定義します。
  final DocumentReference postRef = FirebaseFirestore.instance.collection('posts').doc(widget.postId); // 投稿の参照を取得します。

  FirebaseFirestore.instance.runTransaction((transaction) async { // トランザクションを開始します。
    DocumentSnapshot postSnapshot = await transaction.get(postRef); // 投稿のスナップショットを取得します。
    if (!postSnapshot.exists) {
      throw Exception("Post does not exist!"); // 投稿が存在しない場合、例外をスローします。
    }

    Map<String, dynamic> postData = postSnapshot.data() as Map<String, dynamic>; // 投稿のデータを取得します。
    int newLikeCount = postData['likeCount'] ?? 0; // 「いいね」の数を取得します。
    transaction.update(postRef, {
      'likeCount': _isLiked ? newLikeCount - 1 : newLikeCount + 1, // 「いいね」の数を更新します。
    });

    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(widget.userId); // ユーザーの参照を取得します。
    DocumentSnapshot userSnapshot = await transaction.get(userRef); // ユーザーのスナップショットを取得します。
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>; // ユーザーのデータを取得します。
    List likedPosts = userData['likedPosts'] ?? []; // ユーザーが「いいね」した投稿のリストを取得します。

    if (_isLiked) {
      likedPosts.remove(widget.postId); // ユーザーが「いいね」を取り消した場合、投稿をリストから削除します。
    } else {
      likedPosts.add(widget.postId); // ユーザーが「いいね」した場合、投稿をリストに追加します。
    }

    transaction.update(userRef, {
      'likedPosts': likedPosts, // ユーザーが「いいね」した投稿のリストを更新します。
    });
  });

  setState(() {
    _isLiked = !_isLiked; // 「いいね」の状態を切り替えます。
  });
}

  @override
  Widget build(BuildContext context) { // ウィジェットをビルドするメソッドを定義します。
    return StreamBuilder<DocumentSnapshot>( // StreamBuilderを使用して、Firestoreのデータの変更をリアルタイムで反映します。
      stream: FirebaseFirestore.instance.collection('posts').doc(widget.postId).snapshots(), // 投稿のデータをストリームとして取得します。
      builder: (context, snapshot) { // ビルダーを定義します。
        if (!snapshot.hasData) {
          return const CircularProgressIndicator(); // データがない場合、ローディングインジケータを表示します。
        }
        int likeCount = snapshot.data?['likeCount'] ?? 0; // 「いいね」の数を取得します。
        return GestureDetector( // GestureDetectorを使用して、タップイベントを処理します。
          onTap: _toggleLike, // タップされたときに「いいね」の状態を切り替えます。
          child: Column( // Columnウィジェットを使用して、子ウィジェットを垂直に配置します。
            children: [
              Icon( // アイコンを表示します。
                _isLiked ? Icons.favorite : Icons.favorite_border, // 「いいね」の状態に応じてアイコンを切り替えます。
                color: _isLiked ? Colors.pink : Theme.of(context).iconTheme.color, // 「いいね」の状態に応じてアイコンの色を切り替えます。
              ),
              Text('$likeCount'), // 「いいね」の数を表示します。
            ],
          ),
        );
      },
    );
  }
}
