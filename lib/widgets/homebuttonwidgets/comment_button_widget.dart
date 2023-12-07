import 'package:flutter/material.dart';
import '/models/homewidgetmodels/comments.dart';


class CommentWidget extends StatelessWidget {
  final Comment comment;

  const CommentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.surface, 
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(backgroundColor: Colors.white,), // プロフィール画像のダミー
              const SizedBox(width: 8.0),
              Text(
                comment.username, 
                style: theme.textTheme.bodyLarge,
              ),
              const Spacer(),
              Text(
                comment.timestamp.toLocal().toString(),
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Text(
            comment.content,
            style: theme.textTheme.bodyMedium, 
          ),
            const SizedBox(height: 8.0),
          Row(
            children: [
              Icon(Icons.thumb_up, color: theme.colorScheme.onSurface),
              const SizedBox(width: 4.0),
              Text(
                '${comment.likes}', 
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(width: 16.0),
              Icon(Icons.thumb_down, color: theme.colorScheme.onSurface), 
              const SizedBox(width: 4.0),
              Text(
                '${comment.dislikes}', 
                style: theme.textTheme.bodyMedium,
              ),
              const Spacer(),
              Text(
                '返信', 
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}