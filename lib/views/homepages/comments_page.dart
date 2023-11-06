

// comments_page.dart
import 'package:flutter/material.dart';
import '../../models/comments.dart';
import '../../widgets/comment_widget.dart';


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
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Comments', style: TextStyle(color: Colors.white)),
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
            hintStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
// TODO このページいらなくね？
// 
