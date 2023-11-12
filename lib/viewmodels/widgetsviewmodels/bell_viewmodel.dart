


// bell_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';


class BellTabViewModel {
  final YourFirebaseService firebaseService;

  BellTabViewModel(this.firebaseService);

  Stream<int> get unreadNotificationsCount => firebaseService.getUnreadNotificationsCount();

  Future<List<Notification>> getNotifications() async {
    return firebaseService.getNotifications();
  }
}

final bellTabViewModelProvider = Provider((ref) {
  // Firebaseサービスのインスタンスを提供
  final firebaseService = ref.read(YourFirebaseServiceProvider);
  return BellTabViewModel(firebaseService);
});
