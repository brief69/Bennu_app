

// profile_page.dart
import 'package:dms/viewmodels/profile_viewmodel.dart';
import 'package:dms/views/profilepages/followers_page.dart';
import 'package:dms/views/profilepages/following_page.dart';
import 'package:dms/views/profilepages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


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
        backgroundColor: const Color.fromARGB(255, 0, 12, 0),
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
          Expanded(
            flex: 7,
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'History'),
                      Tab(text: 'Wallet'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        const Column(
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
                                  // TODO:それぞれのタブの中身を実装
                                  // TODO: post,like,buyは、全て同じようなグリッドビューで表示、viewのコードは使い回して、ユーザーが今いる画面に応じて取得するデータのみ変更して表示する。
                                ],
                              ),
                            ),
                          ],
                        ),
                        ListView(
                          // ウォレットのリストビューの中身を実装
                          // Walletの中身は、Listviewで表示されており、solanaトークンの送受信、円の支払い履歴などの全てを表示する。将来的には検索機能をつけるが今はしない。
                          // 必要なデータは、支払った日、受け取った日、その額、berryかjpyのどちらで支払ったのかの単位、支払った対象のcaptionの一部、
                        ),
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
