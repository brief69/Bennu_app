import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/models/user.dart';

// 現在ログインしているユーザーの状態を管理するプロバイダー
final currentUserProvider = StateProvider<User?>((ref) {
  // 初期状態は null。後でログイン処理によって更新される
  return null;
});
