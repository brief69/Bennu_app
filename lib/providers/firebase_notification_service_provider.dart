import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/services/firebase_notification_service.dart';

// FirebaseNotificationServiceのインスタンスを提供するプロバイダーを定義します
final firebaseNotificationServiceProvider = Provider<FirebaseNotificationService>((ref) {
  return FirebaseNotificationService();
});
