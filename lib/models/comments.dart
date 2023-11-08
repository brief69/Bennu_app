

// comments.dart
class Comment {
  final String username;
  final String content;
  final DateTime timestamp;
  int likes;
  int dislikes;

  Comment({
    required this.username,
    required this.content,
    required this.timestamp,
    this.likes = 0,
    this.dislikes = 0,
  });
}
 
// TODO: #4 んー、widgetのmodelはwidgetsに全部まとめたらあかんかな。。？