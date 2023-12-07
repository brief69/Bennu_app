// followers_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// フォロワーページを表示するためのウィジェット
class FollowersPage extends StatelessWidget {
  final String uid;
  // コンストラクタ：ユーザーIDが必要
  const FollowersPage({super.key, required this.uid});

  @override
  // ビルドメソッド：ウィジェットの主要部分を定義
  Widget build(BuildContext context) {
    // Scaffoldウィジェットを返す
    return Scaffold(
      // アプリバーにタイトルを設定
      appBar: AppBar(title: const Text('Followers')),
      // ボディ部分はStreamBuilderウィジェット
      body: StreamBuilder<DocumentSnapshot>(
        // Firestoreからユーザーのドキュメントをストリームとして取得
        stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
        // ビルダー関数：ストリームの現在のスナップショットに基づいてウィジェットを作成
        builder: (context, snapshot) {
          // データがロード中の場合、進行状況インジケータを表示
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          // フォロワーリストを取得
          final followersList = (snapshot.data?.data() as Map<String, dynamic>)['followers'] as List<dynamic>;

          // ListView.builderを使用してフォロワーリストを表示
          return ListView.builder(
            itemCount: followersList.length,
            itemBuilder: (context, index) {
              // 各リストアイテムはListTileウィジェット
              return ListTile(title: Text(followersList[index]));
            },
          );
        },
      ),
    );
  }
}
