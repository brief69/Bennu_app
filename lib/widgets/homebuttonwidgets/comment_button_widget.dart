import 'package:flutter/material.dart';
import '/models/homewidgetmodels/comments.dart';

// コメントウィジェットを表示するためのStatelessWidgetを定義します。
class CommentWidget extends StatelessWidget {
  final Comment comment; // コメントデータ

  // コンストラクタ。コメントデータを必須パラメータとして受け取ります。
  const CommentWidget({super.key, required this.comment});

  // ウィジェットを描画します。
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // 現在のテーマデータを取得します。
    return Container(
      color: theme.colorScheme.surface, // コンテナの色をテーマの表面色に設定します。
      padding: const EdgeInsets.all(8.0), // 全ての辺に8.0のパディングを追加します。
      child: Column( // 子ウィジェットを縦に並べます。
        crossAxisAlignment: CrossAxisAlignment.start, // 子ウィジェットを開始位置に揃えます。
        children: [ // 子ウィジェットのリストを作成します。
          Row( // 子ウィジェットを横に並べます。
            children: [ // 子ウィジェットのリストを作成します。
              const CircleAvatar(backgroundColor: Colors.white,), // プロフィール画像のダミー
              const SizedBox(width: 8.0), // 幅8.0の空間を作成します。
              Text(
                comment.username, // コメントのユーザー名を表示します。
                style: theme.textTheme.bodyLarge, // テキストのスタイルを設定します。
              ),
              const Spacer(), // 可能な限りの空間を作成します。
              Text(
                comment.timestamp.toLocal().toString(), // コメントのタイムスタンプを表示します。
                style: theme.textTheme.bodySmall, // テキストのスタイルを設定します。
              ),
            ],
          ),
          const SizedBox(height: 4.0), // 高さ4.0の空間を作成します。
          Text(
            comment.content, // コメントの内容を表示します。
            style: theme.textTheme.bodyMedium, // テキストのスタイルを設定します。
          ),
            const SizedBox(height: 8.0), // 高さ8.0の空間を作成します。
          Row( // 子ウィジェットを横に並べます。
            children: [ // 子ウィジェットのリストを作成します。
              Icon(Icons.thumb_up, color: theme.colorScheme.onSurface), // いいねのアイコンを表示します。
              const SizedBox(width: 4.0), // 幅4.0の空間を作成します。
              Text(
                '${comment.likes}', // いいねの数を表示します。
                style: theme.textTheme.bodyMedium, // テキストのスタイルを設定します。
              ),
              const SizedBox(width: 16.0), // 幅16.0の空間を作成します。
              Icon(Icons.thumb_down, color: theme.colorScheme.onSurface), // いいねしないのアイコンを表示します。
              const SizedBox(width: 4.0), // 幅4.0の空間を作成します。
              Text(
                '${comment.dislikes}', // いいねしないの数を表示します。
                style: theme.textTheme.bodyMedium, // テキストのスタイルを設定します。
              ),
              const Spacer(), // 可能な限りの空間を作成します。
              Text(
                '返信', // "返信"というテキストを表示します。
                style: theme.textTheme.bodyMedium, // テキストのスタイルを設定します。
              ),
            ],
          ),
        ],
      ),
    );
  }
}