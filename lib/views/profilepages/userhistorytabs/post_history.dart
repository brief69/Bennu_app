import 'package:bennu/viewmodels/media_viewmodel.dart';
import 'package:bennu/widgets/grid_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ユーザーの投稿履歴を表示するタブのウィジェットを定義
class PostHistoryTab extends StatefulWidget {
  final String userId;

  // コンストラクタ
  const PostHistoryTab({Key? key, required this.userId}) : super(key: key);

  // PostHistoryTabStateを作成
  @override
  PostHistoryTabState createState() => PostHistoryTabState();
}

// PostHistoryTabの状態を管理するクラス
class PostHistoryTabState extends State<PostHistoryTab> {
  // ウィジェットのビルドメソッド
  @override
  Widget build(BuildContext context) {
    // Scaffoldウィジェットを返す
    return Scaffold(
      // StreamBuilderを使用してFirestoreからデータを取得
      body: StreamBuilder(
        // 'posts'コレクションからuserIdが一致するドキュメントを取得
        stream: FirebaseFirestore.instance
            .collection('posts')
            .where('userId', isEqualTo: widget.userId)
            .snapshots(),
        // データが取得できたらGridViewWidgetを表示
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // データがない場合はCircularProgressIndicatorを表示
          if (!snapshot.hasData) return const CircularProgressIndicator();

          // 取得したドキュメントをMediaViewModelのリストに変換
          var mediaList = snapshot.data!.docs
              .map((doc) => MediaViewModel.fromDocument(doc))
              .toList();

          // GridViewWidgetを返す
          return GridViewWidget(
            mediaList: mediaList,
            pageType: PageType.history,
          );
        },
      ),
    );
  }
}
