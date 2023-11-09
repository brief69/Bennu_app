

// comment_widget.dart
import 'package:flutter/material.dart';
import '../../models/widgetmodels/comments.dart';


class CommentWidget extends StatelessWidget {
  final Comment comment;

  const CommentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(backgroundColor: Colors.white,), // プロフィール画像のダミー
              const SizedBox(width: 8.0),
              Text(comment.username, style: const TextStyle(color: Colors.white)),
              const Spacer(),
              Text(
                comment.timestamp.toLocal().toString(),
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Text(comment.content, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 8.0),
          Row(
            children: [
              const Icon(Icons.thumb_up, color: Colors.white),
              const SizedBox(width: 4.0),
              Text('${comment.likes}', style: const TextStyle(color: Colors.white)),
              const SizedBox(width: 16.0),
              const Icon(Icons.thumb_down, color: Colors.white),
              const SizedBox(width: 4.0),
              Text('${comment.dislikes}', style: const TextStyle(color: Colors.white)),
              const Spacer(),
              const Text('返信', style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
