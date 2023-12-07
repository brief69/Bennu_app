// following_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// フォロー中のユーザーを表示するためのウィジェット
class FollowingPage extends StatelessWidget {
  final String uid;
  // コンストラクタ：ユーザーIDが必要
  const FollowingPage({super.key, required this.uid});

  @override
  // ビルドメソッド：ウィジェットの主要部分を定義
  Widget build(BuildContext context) {
    // テーマデータを取得
    final theme = Theme.of(context); 
    // Scaffoldウィジェットを返す
    return Scaffold(
      // アプリバーにタイトルを設定
      appBar: AppBar(
        title: Text('Following', style: theme.appBarTheme.titleTextStyle),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      // ボディ部分はStreamBuilderウィジェット
      body: StreamBuilder<DocumentSnapshot>(
        // Firestoreからユーザーのドキュメントをストリームとして取得
        stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
        // ビルダー関数：ストリームの現在のスナップショットに基づいてウィジェットを作成
        builder: (context, snapshot) {
          // データがロード中の場合、進行状況インジケータを表示
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: theme.primaryColor),
            );
          }
          // フォロー中のユーザーリストを取得
          final followingList = (snapshot.data?.data() as Map<String, dynamic>)['following'] as List<dynamic>;

          // ListView.builderを使用してフォロー中のユーザーリストを表示
          return ListView.builder(
            itemCount: followingList.length,
            itemBuilder: (context, index) {
              // 各リストアイテムはListTileウィジェット
              return ListTile(
                title: Text(
                  followingList[index],
                  style: theme.textTheme.bodyLarge,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
