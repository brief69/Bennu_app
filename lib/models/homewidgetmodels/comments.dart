class Comment {
  final String username;
  final String userIcon;
  final String content;
  final DateTime timestamp;
  int likes;
  int dislikes;

  Comment({
    required this.username,
    required this.userIcon,
    required this.content,
    required this.timestamp,
    this.likes = 0,
    this.dislikes = 0,
  });
}