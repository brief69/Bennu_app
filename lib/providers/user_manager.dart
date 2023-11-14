

// user_manager.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import 'current_user_provider.dart';

// Firestoreからユーザー情報を取得する関数
Future<Map<String, dynamic>> fetchUserDetails(String userId) async {
  // Firestoreのインスタンスを取得
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // ユーザー情報を取得
  DocumentSnapshot userDoc = await firestore.collection('users').doc(userId).get();

  if (userDoc.exists) {
    return userDoc.data() as Map<String, dynamic>;
  } else {
    throw Exception('User not found');
  }
}

// ユーザーのログイン処理を行う関数（例）
Future<void> loginUser(WidgetRef ref, String userId) async {
  try {
    // Firestoreからユーザー情報を取得
    Map<String, dynamic> userDetails = await fetchUserDetails(userId);

    // ユーザーオブジェクトを作成
    User user = User(
      id: userId,
      userName: userDetails['userName'] ?? '',
      userIcon: userDetails['userIcon'] ?? '',
      solanaAddress: userDetails['solanaAddress'] ?? '',
      postHistory: userDetails['postHistory'] ?? [],
      likesHistory: userDetails['likesHistory'] ?? [],
      buyHistory: userDetails['buyHistory'] ?? [],
      followingCount: userDetails['followingCount'] ?? 0,
      followerCount: userDetails['followerCount'] ?? 0,
    );

    // currentUserProviderの状態を更新
    ref.read(currentUserProvider.notifier).state = user;
  } catch (e) {
    // エラーハンドリング（ログイン失敗やデータ取得エラー）
    // 必要に応じてさらなるエラーハンドリングを行う
  }
}


// user_manager.dart の役割
// user_manager.dart は、アプリケーション全体の現在のユーザー状態を管理します。
// 主に以下を担当します：

// 現在のユーザーのログイン状態の管理
// ユーザーのログインとログアウトの処理
// 現在ログインしているユーザーの基本情報の保持
// このファイルでは、Riverpodの StateProvider を使用して、現在のユーザーの情報を保持し、更新します。