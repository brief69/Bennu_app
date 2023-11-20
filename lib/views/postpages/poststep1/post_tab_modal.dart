

// post_tab_modal.dart
import 'package:bennu_app/views/postpages/poststep1/camera_tab.dart';
import 'package:bennu_app/views/postpages/poststep1/relay_tab.dart';
import 'package:bennu_app/views/postpages/poststep1/video_gallery_tab.dart';
import 'package:flutter/material.dart';

class PostTabModal extends StatelessWidget {
  const PostTabModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: const TabBarView(
            children: [
              VideoGalleryTab(),
              CameraTab(),
              RepostTab(userId: '',),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.movie),
                label: '動画',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera),
                label: 'ショート',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'リレー',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
