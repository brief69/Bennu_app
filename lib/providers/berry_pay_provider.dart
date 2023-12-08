import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/viewmodels/billviewmodels/berry_pay_viewmodel.dart';
import '/widgets/actionwidgets/berry_pay_widget.dart';


final paymentViewModelProvider = FutureProvider<PaymentViewModel>((ref) async {
  // Firestoreからデータを取得
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final DocumentSnapshot sellerSnapshot = await firestore.collection('users').doc('sellerId').get();
  final DocumentSnapshot buyerSnapshot = await firestore.collection('users').doc('buyerId').get();
  final DocumentSnapshot productSnapshot = await firestore.collection('products').doc('productId').get();

  // UserProfileを初期化
  final sellerProfile = UserProfile(
    solanaAddress: sellerSnapshot['solanaAddress'],
    username: sellerSnapshot['username'],
  );
  final buyerProfile = UserProfile(
    solanaAddress: buyerSnapshot['solanaAddress'],
    username: buyerSnapshot['username'],
  );

  // 商品の価格を取得
  final double price = productSnapshot['price'];

  // PaymentViewModelを初期化
  return PaymentViewModel(
    receiverProfile: sellerProfile,
    senderProfile: buyerProfile,
    amount: price,  // 商品の価格に応じてamountを設定
  );
});