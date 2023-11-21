

// post_tab_modal.dart
import 'package:bennu_app/views/postpages/poststep1/camera_tab.dart';
import 'package:bennu_app/views/postpages/poststep1/relay_tab.dart';
import 'package:bennu_app/views/postpages/poststep1/video_gallery_tab.dart';
import 'package:flutter/material.dart';

class PostTabModal extends StatelessWidget {
  const PostTabModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          ),
        ),
      ),
    );
  }
}
