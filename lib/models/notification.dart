

// notification.dart
class Notification {
  final String title;
  final String body;
  final bool isRead;

  Notification({required this.title, required this.body, this.isRead = false});

  // JSONからNotificationオブジェクトを作成
  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      title: json['title'],
      body: json['body'],
      isRead: json['isRead'],
    );
  }
}
