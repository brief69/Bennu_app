import 'package:flutter/material.dart';
import '/models/homewidgetmodels/comments.dart';
import '/widgets/homebuttonwidgets/comment_button_widget.dart';

// コメントページのウィジェットを定義するクラス
class CommentsPage extends StatelessWidget {
  // ダミーのコメントリストを作成
  final List<Comment> comments = [
    Comment(
      username: 'user1',
      content: 'Great video!',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)), userIcon: '',
    ),
  ];

  // コンストラクタ
  CommentsPage({super.key});

  // ウィジェットのビルドメソッド
  @override
  Widget build(BuildContext context) {
    // テーマデータを取得
    final theme = Theme.of(context);

    // スカフォールドを返す
    return Scaffold(
      // 背景色を設定
      backgroundColor: theme.colorScheme.surface,
      // アプリバーを設定
      appBar: AppBar(
        // アプリバーの背景色を設定
        backgroundColor: theme.appBarTheme.backgroundColor,
        // アプリバーのタイトルを設定
        title: Text(
          'Comments', 
          // アプリバーのタイトルのスタイルを設定
          style: theme.appBarTheme.titleTextStyle,
        ),
      ),
      // ボディ部分を設定（コメントリスト）
      body: ListView.builder(
        // コメントの数だけアイテムを作成
        itemCount: comments.length,
        // 各アイテムのビルドを定義
        itemBuilder: (context, index) {
          // コメントウィジェットを返す
          return CommentWidget(comment: comments[index]);
        },
      ),
      // ボトムナビゲーションバーを設定（コメント入力フィールド）
      bottomNavigationBar: Padding(
        // パディングを設定
        padding:  const EdgeInsets.all(8.0),
        // テキストフィールドを子として設定
        child: TextFormField(
          // デコレーションを設定
          decoration:  InputDecoration(
            // 背景色を設定
            fillColor: Colors.white,
            // 背景色を有効にする
            filled: true,
            // ヒントテキストを設定
            hintText: 'コメントを入力...',
            // ヒントテキストのスタイルを設定
            hintStyle: theme.textTheme.bodyMedium,
            // ボーダーを設定
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}

