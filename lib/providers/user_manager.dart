

// user_manager.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

// 現在ログインしているユーザーの状態を管理するプロバイダー
final currentUserProvider = StateProvider<User?>((ref) {
  // 初期状態はnullか、既に認証されているユーザー情報を設定
  return null; 
});

// ユーザーのログイン処理を行う関数（例）
Future<void> loginUser(WidgetRef ref, String userId) async {
  // ログイン処理...
  // ログインに成功したら、currentUserProviderの状態を更新
  ref.read(currentUserProvider.notifier).state = 
    User(
      id: userId, 
      userName: '', 
      userIcon: '', 
      solanaAddress: '', 
      postHistory: [], 
      likesHistory: [], 
      buyHistory: [], 
      followingCount: , 
      followerCount: ,
    );
}

// ユーザーのログアウト処理を行う関数（例）
void logoutUser(WidgetRef ref) {
  // ログアウト処理...
  // currentUserProviderの状態をnullにリセット
  ref.read(currentUserProvider.notifier).state = null;
}


// user_manager.dart の役割
// user_manager.dart は、アプリケーション全体の現在のユーザー状態を管理します。
// 主に以下を担当します：

// 現在のユーザーのログイン状態の管理
// ユーザーのログインとログアウトの処理
// 現在ログインしているユーザーの基本情報の保持
// このファイルでは、Riverpodの StateProvider を使用して、現在のユーザーの情報を保持し、更新します。