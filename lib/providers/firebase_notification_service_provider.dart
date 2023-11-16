

// firebase_notification_service_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/firebase_notification_service.dart';

final firebaseNotificationServiceProvider = Provider<FirebaseNotificationService>((ref) {
  return FirebaseNotificationService();
});
