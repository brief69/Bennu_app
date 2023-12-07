import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bennu/models/homewidgetmodels/media_model.dart';
import 'package:bennu/providers/current_user_provider.dart';
import 'package:bennu/providers/user_media_providers.dart';
import 'package:bennu/viewmodels/media_viewmodel.dart';
import 'package:bennu/viewmodels/profile_viewmodel.dart';
import 'package:bennu/widgets/grid_view_widget.dart';
import 'edit_profile_page.dart';
import 'followers_page.dart';
import 'following_page.dart';
import 'settings_page.dart';


final viewModelProvider = Provider<ProfileViewModel>((ref) => ProfileViewModel()); // ProfileViewModelを提供するProviderを定義
final userPostsProvider = FutureProvider<List<MediaModel>>((ref) async { // ユーザーの投稿を提供するFutureProviderを定義
    // ここでユーザーの投稿を取得するロジック
      return []; // 仮のデータ
    });

class ProfilePage extends ConsumerWidget { // ConsumerWidgetを継承したProfilePageクラスを定義
  const ProfilePage({super.key}); // コンストラクタを定義

  @override
  Widget build(BuildContext context, WidgetRef ref) { // buildメソッドをオーバーライド
    final currentUser = ref.watch(currentUserProvider); // 現在のユーザー情報を取得
    final viewModel = ref.watch(viewModelProvider); // ProfileViewModelを取得
    final theme = Theme.of(context);  // 現在のテーマデータを取得

    // ダミーデータの定義
    const dummyUsername = 'user000';
// assetsフォルダに追加したダミーのQRコード画像

    // 現在のユーザーがnullの場合、ダミーデータを使用
    final isUserAvailable = currentUser != null;



    if (currentUser != null) { // 現在のユーザーがnullでない場合
      viewModel.loadUserData(currentUser.id); // ユーザー情報をProfileViewModelにロード
    }

    void goToEditProfilePage() { // プロフィール編集ページへ遷移する関数を定義
      Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage()));
    }

    void showFollowers() { // フォロワーページを表示する関数を定義
      if (currentUser != null) { // 現在のユーザーがnullでない場合
        Navigator.push(context, MaterialPageRoute(builder: (context) => FollowersPage(uid: currentUser.id)));
      }
    }

    void showFollowing() { // フォロー中ページを表示する関数を定義
      if (currentUser != null) { // 現在のユーザーがnullでない場合
        Navigator.push(context, MaterialPageRoute(builder: (context) => FollowingPage(uid: currentUser.id)));
      }
    }

    final userPosts = ref.watch(userPostsProvider); // 投稿履歴のデータを取得
    final userLikes = ref.watch(userLikesProvider); // いいね履歴のデータを取得
    final userBuys = ref.watch(userBuysProvider); // 購入履歴のデータを取得

    return Scaffold( // Scaffoldウィジェットを返す
      appBar: AppBar( // AppBarを定義
        title: Text("Profile", style: theme.textTheme.titleLarge), // タイトルを設定
        backgroundColor: theme.appBarTheme.backgroundColor, // AppBarの背景色を設定
        centerTitle: true, // タイトルを中央に配置
        actions: [ // 右上のアクションボタンを定義
          IconButton( // IconButtonを定義
            icon: const Icon(Icons.settings, color: Colors.white), // アイコンを設定
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage())), // 押下時のアクションを定義
          ),
        ],
      ),
      body: Column( // body部分をColumnウィジェットで定義
        children: [ // Columnの子ウィジェットを定義
          Expanded( // Expandedウィジェットを使用して領域を均等に分割
            flex: 2, // 領域の比率を設定
            child: Container( // Containerウィジェットを定義
              color: theme.colorScheme.primary, // 背景色を設定
              child: Row( // Rowウィジェットを定義
                children: [ // Rowの子ウィジェットを定義
                  Expanded( // Expandedウィジェットを使用して領域を均等に分割
                    flex: 1, // 領域の比率を設定
                    child: Column( // Columnウィジェットを定義
                      children: [ // Columnの子ウィジェットを定義
                        Expanded( // Expandedウィジェットを使用して領域を均等に分割
                    flex: 1, // 領域の比率を設定
                    child: Column( // Columnウィジェットを定義
                      children: [ // Columnの子ウィジェットを定義
                        const SizedBox(height: 9), // ユーザーアイコンの位置を下に移動するためのSizedBox
                        GestureDetector( // GestureDetectorウィジェットを定義
                          onTap: () => viewModel.pickUserIcon(), // タップ時のアクションを定義
                          child: viewModel.userIcon != null 
                          ? Image.network(viewModel.userIcon!, width: 180, height: 180) // ユーザーアイコンのサイズを変更
                          : Image.asset('assets/kkrn_icon_user_5.png', width: 180, height: 180), // デフォルトアイコンのサイズを変更
                        ),
                        Column( // Columnウィジェットを定義
                          children: [ // Columnの子ウィジェットを定義
                            ElevatedButton( // ElevatedButtonウィジェットを定義
                              onPressed: goToEditProfilePage, // 押下時のアクションを定義
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(isUserAvailable ? viewModel.username : dummyUsername, style: const TextStyle(color: Colors.white, fontSize: 21)), // 直接条件を渡す
                              ),
                            ),
                            const SizedBox(height: 0), // スペースを設定
                            GestureDetector( // GestureDetectorウィジェットを定義
                              onTap: showFollowers, // タップ時のアクションを定義
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('follow ${viewModel.followersCount}', style: const TextStyle(fontSize: 18)), // テキストを設定
                              ),
                            ),
                            const SizedBox(height: 0), // スペースを設定
                            GestureDetector( // GestureDetectorウィジェットを定義
                              onTap: showFollowing, // タップ時のアクションを定義
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('follower ${viewModel.followingCount}', style: const TextStyle(fontSize: 18)), // テキストを設定
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                        ),
                      ],
                    ),
                  ),
                  Expanded( // Expandedウィジェットを使用して領域を均等に分割
                    flex: 1, // 領域の比率を設定
                    child: Column( // Columnウィジェットを定義
                      children: [ // Columnの子ウィジェットを定義
                      const SizedBox(height: 25),
                        GestureDetector( // GestureDetectorウィジェットを定義
                          onTap: () => viewModel.goToQRPage(), // タップ時のアクションを定義
                          child: ClipRRect( // ClipRRectウィジェットを使用して画像の角を丸くする
                            borderRadius: BorderRadius.circular(20), // 角の半径を設定
                            child: viewModel.qrImageData != null
                              ? Image.memory(viewModel.qrImageData!, width: 150, height: 150)  // 実際のQRコード画像がある場合は表示
                              : currentUser == null
                                ? Image.asset('assets/dummy_qr.png', width: 150, height: 150) // ユーザーが未登録かオフラインの場合はダミーのQRコード画像を表示
                                : const CircularProgressIndicator(), // それ以外の場合（データをロード中）はローディングインジケータを表示
                          ),
                        ),
                        const SizedBox(height: 25), // QRコードと公開キーの間にスペースを追加
                        GestureDetector( // GestureDetectorウィジェットを定義
                          onTap: () => viewModel.copySolanaAddress(), // タップ時のアクションを定義
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                            color: Colors.white, // 背景色を白に設定
                            borderRadius: BorderRadius.circular(10), // 角の半径を設定
                            ),
                            child: Text(
                              currentUser != null ? viewModel.solanaAddress : '3FZbgi29cpjq2GjdwV8eyHuJJnkLtktZc511111111111111111111111111111',
                              maxLines: 3, // テキストを設定
                              style: const TextStyle(color: Colors.black), // テキストのスタイルを設定
                            ),
                          ),
                        ), 
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded( // Expandedウィジェットを使用して領域を均等に分割
            flex: 3, // 領域の比率を設定
            child: DefaultTabController( // DefaultTabControllerウィジェットを定義
              length: 3, // タブの数を設定
              child: Column( // Columnウィジェットを定義
                children: [ // Columnの子ウィジェットを定義
                  Container( // Containerウィジェットを定義
                    color: theme.colorScheme.primary, // 背景色を設定
                    child: TabBar( // TabBarウィジェットを定義
                      indicator: BoxDecoration( // インジケータのスタイルを設定
                        color: theme.primaryColor, // インジケータの色を設定
                      ),
                      tabs: const [ // タブのリストを設定
                        Tab(icon: Icon(Icons.add)),
                        Tab(icon: Icon(Icons.favorite)),
                        Tab(icon: Icon(Icons.shopping_cart)),
                      ],
                    ),
                  ),
                  Expanded( // Expandedウィジェットを使用して領域を均等に分割
                    child: TabBarView( // TabBarViewウィジェットを定義
                      children: [ // 各タブのビューを設定
                        buildGridView(userPosts, PageType.history), // 投稿履歴のビューを設定
                        buildGridView(userLikes, PageType.likes), // いいね履歴のビューを設定
                        buildGridView(userBuys, PageType.purchase), // 購入履歴のビューを設定
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridView(AsyncValue<List<MediaModel>> asyncMediaList, PageType pageType) { // GridViewを生成する関数を定義
    return asyncMediaList.when( // AsyncValueの状態に応じてウィジェットを返す
      data: (List<MediaModel> mediaList) { // データが存在する場合
        List<MediaViewModel> mediaViewModels = mediaList.map((mediaModel) {
          return MediaViewModel(mediaModel); // 仮の変換処理
        }).toList();
        return GridViewWidget(mediaList: mediaViewModels, pageType: pageType); // GridViewWidgetを返す
      },
      loading: () => const CircularProgressIndicator(), // ローディング中の表示
      error: (e, st) => Text('Error: $e'), // エラー発生時の表示
    );
  }
}




