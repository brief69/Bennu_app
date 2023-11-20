

import 'package:bennu_app/views/postpages/poststep2/video_editor_interface.dart';
import 'package:bennu_app/viewmodels/media_viewmodel.dart';
import 'package:bennu_app/widgets/grid_view_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RepostTab extends StatelessWidget {
  final String userId;

  const RepostTab({super.key, required this.userId});
  
  get videos => null;
  get index => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RePost'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('purchases')
            .where('userId', isEqualTo: userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            List<MediaViewModel> mediaList = snapshot.data!.docs
                .map((doc) => MediaViewModel.fromDocument(doc))
                .toList();

            return GridViewWidget(
              mediaList: mediaList,
              pageType: PageType.relay,
              customItemBuilder: (mediaItem) => InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoEditorInterface(
                        videoFile: videos![index], 
                        purchaseId: mediaItem.id, 
                        videoUrl: mediaItem.videoUrl, // URLを直接渡す
                      ),
                    )
                  );
                },
                child: Card(
                  child: Column(
                    children: [
                      // ここに動画プレーヤーウィジェットを配置
                      Text(mediaItem.caption),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Text('No purchase history found.');
          }
        },
      ),
    );
  }
}
