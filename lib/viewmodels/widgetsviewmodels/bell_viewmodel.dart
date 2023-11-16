

// bell_viewmodel.dart
import 'package:bennu_app/providers/firebase_notification_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/firebase_notification_service.dart';
// ignore: library_prefixes
import 'package:bennu_app/models/notification.dart' as modelNotification;


class BellTabViewModel {
  final FirebaseNotificationService firebaseService;

  BellTabViewModel(this.firebaseService);

  Future<int> get unreadNotificationsCount => firebaseService.getUnreadNotificationsCount();

  // getNotificationsメソッドの戻り値の型を修正
  Future<List<modelNotification.Notification>> getNotifications() async {
    return firebaseService.fetchNotifications();
  }
}

final bellTabViewModelProvider = Provider<BellTabViewModel>((ref) {
  // 正しいプロバイダの型を指定
  final firebaseService = ref.read(firebaseNotificationServiceProvider);
  return BellTabViewModel(firebaseService);
});
