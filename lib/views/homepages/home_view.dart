

// home_view.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/media_model.dart';
import '../../viewmodels/media_viewmodel.dart';
import '../../widgets/bell_tab_widget.dart';
import 'media_item_view.dart';

class HomeView extends StatefulWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // コンストラクタでキーを初期化します（任意）
  HomeView({Key? key}) : super(key: key);

  // ステートオブジェクトを作成します。
  @override
  HomeViewState createState() => HomeViewState();
}

// HomeViewのステートクラスを定義します。
class HomeViewState extends State<HomeView> {
  // FirestoreのドキュメントからMediaViewModelを作成する関数
  MediaViewModel _createViewModelFromDocument(DocumentSnapshot doc) {
    return MediaViewModel(
      MediaModel(
        firestore: widget.firestore, videoUrl: '', userIcon: '', likes: 0, comments: 0, other: '', buy: 0, incart: 0, shares: 0, caption: '', stock: 0, price: 0, relay: 0, postId: '', userId: '',
      ),
    );
  }

  // ウィジェットのビルドメソッド
  @override
  Widget build(BuildContext context) {
    // DefaultTabControllerを使用してタブバーを持つScaffoldウィジェットを作成します。
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent, // AppBarの背景色透明。
          // タブバーをAppBarのbottomに設定します。
          bottom: const TabBar(
            tabs: [
              Tab(text: 'おすすめ'),
              Tab(text: 'フォロー'),
              Tab(icon: Icon(Icons.notifications)),
            ],
          ),
        ),
        body:  TabBarView(
          children: [
            // おすすめタブのコンテンツ
            // フォロータブのコンテンツ
            const BellTabWidget(),// 通知タブのコンテンツとしてBellTabWidgetを使用
        // StreamBuilderを使用してFirestoreのデータストリームを購読します。
          StreamBuilder(
            stream: widget.firestore.collection('posts').snapshots(), // 'posts'コレクションのスナップショットを購読
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // データがまだない場合はローディングインジケータを表示します。
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
            // メディアアイテムのリストを初期化します。
              List<MediaItemView> mediaItems = [];
            // Firestoreから取得したドキュメントのリストを繰り返し処理します。
              for (var doc in snapshot.data!.docs) {
              // 各ドキュメントからMediaItemViewを作成し、リストに追加します。
                mediaItems.add(MediaItemView(
                // Firestoreドキュメントの各フィールドからウィジェットにデータを渡します。
                // _createViewModelFromDocument関数を使用してViewModelを生成し、ウィジェットに渡します。
                  viewModel: _createViewModelFromDocument(doc),
                ));
              }
            // 作成したメディアアイテムのリストをListViewで表示します。
              return ListView(children: mediaItems);
            },
          ),
          ],
        ),
      ),
    );
  }
}