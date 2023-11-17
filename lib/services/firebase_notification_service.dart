

// firebase_notification_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
// ignore: library_prefixes
import 'package:bennu_app/models/notification.dart' as modelNotification;

class FirebaseNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // 通知の初期化と設定
  Future<void> initialize() async {
    // アプリがフォアグラウンドにある時に通知を受け取るための設定
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // ここに通知が到着した時の処理を書く
      // ignore: avoid_print
      print("Message received. Title: ${message.notification?.title}, Body: ${message.notification?.body}");
    });

    // アプリがバックグラウンド/終了状態で通知をタップしたときの処理
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // ここにユーザーが通知をタップした時の処理を書く
      // ignore: avoid_print
      print("Message clicked. Title: ${message.notification?.title}, Body: ${message.notification?.body}");
    });
  }

  // デバイストークンの取得
  Future<String> getDeviceToken() async {
    return await _firebaseMessaging.getToken() ?? '';
  }
  // 未読通知のカウントを取得
  Future<int> getUnreadNotificationsCount() async {
    var url = Uri.parse('https://yourserver.com/unread-count');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return int.parse(response.body); // サーバーからの応答を整数に変換
    } else {
      throw Exception('Failed to load unread notifications count');
    }
  }

  // サーバーから通知リストを取得
  Future<List<modelNotification.Notification>> fetchNotifications() async {
    var url = Uri.parse('https://yourserver.com/notifications');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> notificationsJson = json.decode(response.body);
      return notificationsJson.map((json) => modelNotification.Notification.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }
}