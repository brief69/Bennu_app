import 'package:flutter/material.dart';
import '/views/postpages/poststep1/camera_tab.dart';
import '/views/postpages/poststep1/relay_tab.dart';
import '/views/postpages/poststep1/video_gallery_tab.dart';

class PostTabModal extends StatefulWidget {
  const PostTabModal({Key? key}) : super(key: key);

  @override
  PostTabModalState createState() => PostTabModalState();
}

class PostTabModalState extends State<PostTabModal> {
  bool isNavBarVisible = true; // ナビゲーションバーの表示状態

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
            children: [
              const VideoGalleryTab(),
              const CameraTab(),
              RepostTab(userId: '',),
            ],
          ),
          bottomNavigationBar: isNavBarVisible // 状態に基づいて表示制御
              ? BottomNavigationBar(
                  backgroundColor: theme.primaryColor,
                  selectedItemColor: theme.colorScheme.secondary, 
                  unselectedItemColor: theme.unselectedWidgetColor,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Text('動画'),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Text('ショート'), 
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Text('リレーする'),
                      label: '',
                    ),
                  ],
                )
              : const SizedBox.shrink(), // ナビゲーションバー非表示時は空のウィジェットを返す
        ),
      ),
    );
  }

  // ナビゲーションバーの表示状態を更新するメソッド
  void toggleNavBarVisibility() {
    setState(() {
      isNavBarVisible = !isNavBarVisible;
    });
  }
}
