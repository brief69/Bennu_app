class Notification {
  // 通知のタイトル
  final String title;
  // 通知の本文
  final String body;
  // 通知が読まれたかどうか
  final bool isRead;

  // コンストラクタ
  Notification({
    required this.title, 
    required this.body, 
    this.isRead = false
  });

  // JSONからNotificationオブジェクトを作成するファクトリメソッド
  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      // タイトルを取得
      title: json['title'],
      // 本文を取得
      body: json['body'],
      // 読まれたかどうかを取得
      isRead: json['isRead'],
    );
  }
}
