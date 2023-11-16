

// profile_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/homewidgetmodels/media_model.dart';
import '../../providers/current_user_provider.dart';
import '../../providers/user_media_providers.dart';
import '../../viewmodels/media_viewmodel.dart';
import '../../viewmodels/profile_viewmodel.dart';
import '../../widgets/grid_view_widget.dart';
import 'edit_profile_page.dart';
import 'followers_page.dart';
import 'following_page.dart';
import 'settings_page.dart';

final viewModelProvider = Provider<ProfileViewModel>((ref) => ProfileViewModel());
final userPostsProvider = FutureProvider<List<MediaModel>>((ref) async {
    // ここでユーザーの投稿を取得するロジックを実装
      return []; // 仮のデータ
    });

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider); // 現在のユーザー情報を取得
    final viewModel = ref.watch(viewModelProvider);
    final theme = Theme.of(context); 

    if (currentUser != null) {
      viewModel.loadUserData(currentUser.id); // ユーザー情報をProfileViewModelにロード
    }

    void goToEditProfilePage() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage()));
    }

    void showFollowers() {
      if (currentUser != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => FollowersPage(uid: currentUser.id)));
      }
    }

    void showFollowing() {
      if (currentUser != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => FollowingPage(uid: currentUser.id)));
      }
    }

    final userPosts = ref.watch(userPostsProvider); // 投稿履歴のデータ
    final userLikes = ref.watch(userLikesProvider); // いいね履歴のデータ
    final userBuys = ref.watch(userBuysProvider); // 購入履歴のデータ

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: theme.textTheme.titleLarge),
        backgroundColor: theme.appBarTheme.backgroundColor,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage())),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => viewModel.pickUserIcon(),
                        child: viewModel.userIcon != null 
                        ? Image.network(viewModel.userIcon!)
                        : Image.asset('path/to/default/image.png'),
                      ),
                      ElevatedButton(
                        onPressed: goToEditProfilePage,
                        child: Text(viewModel.username),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: showFollowers,
                            child: Text('follow ${viewModel.followersCount}'),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: showFollowing,
                            child: Text('follower ${viewModel.followingCount}'),
                          ),
                        ],
                      ),
                    ],
                  ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => viewModel.goToQRPage(),
                        child: viewModel.qrImageData != null 
                            ? Image.memory(viewModel.qrImageData!) 
                            : const CircularProgressIndicator(),
                      ),
                      GestureDetector(
                        onTap: () => viewModel.copySolanaAddress(),
                        child: Text(viewModel.solanaAddress, maxLines: 2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'Post'),
                      Tab(text: 'Likes'),
                      Tab(text: 'Buy'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        buildGridView(userPosts, PageType.history),
                        buildGridView(userLikes, PageType.likes),
                        buildGridView(userBuys, PageType.purchase),
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

  Widget buildGridView(AsyncValue<List<MediaModel>> asyncMediaList, PageType pageType) {
    return asyncMediaList.when(
      data: (List<MediaModel> mediaList) {
        List<MediaViewModel> mediaViewModels = mediaList.map((mediaModel) {
          return MediaViewModel(mediaModel); // 仮の変換処理
        }).toList();
        return GridViewWidget(mediaList: mediaViewModels, pageType: pageType);
      },
      loading: () => const CircularProgressIndicator(), // ローディング中の表示
      error: (e, st) => Text('Error: $e'), // エラー発生時の表示
    );
  }
}
