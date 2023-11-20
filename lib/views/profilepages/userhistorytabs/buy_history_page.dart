

// buy_history_tab.dart
// ユーザーの購入履歴を表示するページ

// 上部にはbalance_widget.dartが配置されており、これは最終的な現在のユーザーの最新の残高を表示示す。
// その下にgrid_view_widget.dartで購入履歴を表示
// // グリッドビュー時に表示するデータは、
// 動画、いくらで購入したのか、いつ購入したのかのタイムスタンプ

import 'package:bennu_app/viewmodels/media_viewmodel.dart';
import 'package:bennu_app/widgets/grid_view_widget.dart';
import 'package:bennu_app/widgets/profile_widget.dart/balance_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BuyHistoryTab extends StatelessWidget {
  final String userId;

  const BuyHistoryTab({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BalanceWidget(userId: userId),
        Expanded(
          child: FutureBuilder<List<MediaViewModel>>(
            future: fetchPurchaseHistory(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {

                return GridViewWidget(
                  mediaList: snapshot.data!,
                  pageType: PageType.purchase,
                  customItemBuilder: (mediaItem) => Column(
                    children: [
                      Text('Price: \$${mediaItem.purchasePrice}'), // 価格を表示
                      Text('Purchased: ${DateFormat('yyyy-MM-dd').format(mediaItem.purchaseDate)}'), // 日付を表示
                    ],
                  ),
                );
              } else {
                return const Text('No purchase history found.');
              }
            },
          ),
        ),
      ],
    );
  }

  Future<List<MediaViewModel>> fetchPurchaseHistory(String userId) async {
    // Firestoreから購入履歴を取得するロジック
    // 以下はサンプルコードであり、実際のFirestoreのデータ構造に応じて変更が必要です
    QuerySnapshot purchaseHistorySnapshot = await FirebaseFirestore.instance
        .collection('purchases')
        .where('userId', isEqualTo: userId)
        .get();

    return purchaseHistorySnapshot.docs
        .map((doc) => MediaViewModel.fromDocument(doc))
        .toList();
  }
}
