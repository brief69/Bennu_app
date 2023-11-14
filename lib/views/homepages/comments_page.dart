

// comments_page.dart
import 'package:flutter/material.dart';
import '../../models/widgetmodels/comments.dart';
import '../../widgets/homebuttonwidgets/comment_button_widget.dart';


class CommentsPage extends StatelessWidget {
  final List<Comment> comments = [
    Comment(
      username: 'user1',
      content: 'Great video!',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    // ... 他のコメントデータ
  ];

  CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Text(
          'Comments', 
          style: theme.appBarTheme.titleTextStyle, 
      ),
      body: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return CommentWidget(comment: comments[index]);
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: const InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'コメントを入力...',
            hintStyle: theme.textTheme.bodyMedium,
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
