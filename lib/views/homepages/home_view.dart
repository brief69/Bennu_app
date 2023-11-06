

// home_view.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/media_model.dart';
import '../../viewmodels/media_viewmodel.dart';
import 'media_item_view.dart';

// ステートフルウィジェットHomeViewを定義します。
class HomeView extends StatefulWidget {
  // Firebase Firestoreのインスタンスを初期化します。
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
    // ドキュメントのデータをMapとして取得します。
    Map<String, dynamic> postData = doc.data() as Map<String, dynamic>;
    // postDataからMediaModelを作成し、それを使用してMediaViewModelを作成します。
    return MediaViewModel(
      MediaModel(
        firestore: widget.firestore,
        // 以下の各フィールドは、Firestoreのドキュメントに対応したキーを使用して値を取得しています。
        // もしデータが存在しない場合はデフォルト値を使用します。
        videoUrl: postData['media'] ?? '',
        userIcon: postData['userIcon'] ?? '',
        likes: postData['likes'] ?? 0,
        comments: postData['comments'] ?? 0,
        other: postData['other'] ?? '',
        buy: postData['Buy'] ?? 0,
        incart: postData['incart'] ?? 0,
        shares: postData['shares'] ?? 0,
        caption: postData['caption'] ?? '',
        stock: postData['stock'] ?? 0,
        price: postData['price'] ?? 0,
      ),
    );
  }

  // ウィジェットのビルドメソッド
  @override
  Widget build(BuildContext context) {
    // DefaultTabControllerを使用してタブバーを持つScaffoldウィジェットを作成します。
    return DefaultTabController(
      length: 3, // タブの数を3つに設定します。
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent, // AppBarの背景色を透明に設定します。
          // タブバーをAppBarのbottomに設定します。
          bottom: const TabBar(
            tabs: [
              Tab(text: 'オススメ'), // おすすめタブ
              Tab(text: 'フォロー'), // フォロータブ
              Tab(text: '通知'), // 通知タブ
            ],
          ),
        ),
        // StreamBuilderを使用してFirestoreのデータストリームを購読します。
        body: StreamBuilder(
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
                caption: doc['caption'],
                itemlimit: doc['itemlimit'],
                postDate: doc['postDate'],
                likes: doc['likes'],
                comments: doc['comments'],
                shares: doc['shares'],
                purchases: doc['Buy'],
                media: doc['media'],
                boxin: doc['boxin'],
                // _createViewModelFromDocument関数を使用してViewModelを生成し、ウィジェットに渡します。
                viewModel: _createViewModelFromDocument(doc),
              ));
            }
            // 作成したメディアアイテムのリストをListViewで表示します。
            return ListView(children: mediaItems);
          },
        ),
      ),
    );
  }
}
