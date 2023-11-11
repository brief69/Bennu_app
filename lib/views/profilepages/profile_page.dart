

// profile_page.dart
// import 'package:dms/viewmodels/profile_viewmodel.dart';
// import 'package:dms/views/profilepages/followers_page.dart';
// import 'package:dms/views/profilepages/following_page.dart';
// import 'package:dms/views/profilepages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/profile_viewmodel.dart';
import 'followers_page.dart';
import 'following_page.dart';
import 'settings_page.dart';


final viewModelProvider = Provider<ProfileViewModel>((ref) => ProfileViewModel());

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(viewModelProvider);

    void goToEditProfilePage() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
    }

    void showFollowers() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const FollowersPage(uid: '',)));
    }

    void showFollowing() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const FollowingPage(uid: '',)));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 0, 12, 0),// TODO: themeを使用するように変更
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
                      GestureDetector(
                        onTap: () => viewModel.pickUserIcon(),
                        child: Image.network(viewModel.userIcon),
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
                      ), // TODO:フォローフォロワーのカウントはバックエンド側で行い、viewmodelでfirestoreから取得して、ここでは取得したデータを表示するのみにする
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
          const Expanded(
            flex: 7,
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: 'Post'),
                      Tab(text: 'Likes'),
                      Tab(text: 'Buy'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // TODO: Implement Post history view
                        // TODO: Implement Likes history view
                        // TODO: Implement Buy history view
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
}
