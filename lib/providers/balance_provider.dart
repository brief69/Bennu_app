import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/models/profilemodels/balance_model.dart';


Future<String> fetchUserId() async {
  // ユーザーIDを取得するロジックを実装
  // 以下は仮のコード
  final user = FirebaseAuth.instance.currentUser; // 現在のユーザーを取得
  return user?.uid ?? ''; // ユーザーIDを返す
}


final balanceFirestoreProvider = StreamProvider<BalanceModel>((ref) async* {
  final userId = await fetchUserId(); // ユーザーIDを取得
  final docSnapshot = await FirebaseFirestore.instance.collection('balances').doc(userId).get(); // Firestoreからバランス情報を取得
  final data = docSnapshot.data(); // データを取得
  yield BalanceModel(balanceInSolana: data?['balanceInSolana'] ?? 0.0, balanceInYen: data?['balanceInYen'] ?? 0.0); // バランスモデルを生成して返す
});

final balanceProvider = StateProvider<BalanceModel>((ref) {
  final balanceData = ref.watch(balanceFirestoreProvider); // Firestoreから取得したバランスデータを監視
  return balanceData.when(
    data: (data) => data, // データがある場合、そのデータを返す
    loading: () => BalanceModel(balanceInSolana: 0.0, balanceInYen: 0.0), // データがロード中の場合、初期値を返す
    error: (_, __) => BalanceModel(balanceInSolana: 0.0, balanceInYen: 0.0),  // エラーが発生した場合、初期値を返す
  );
});

final showBalanceProvider = StateProvider<bool>((ref) => true); // バランス表示の状態を管理するプロバイダー
final currencyDisplayProvider = StateProvider<bool>((ref) => true); // 表示通貨の状態を管理するプロバイダー（trueでSolana、falseで円）
