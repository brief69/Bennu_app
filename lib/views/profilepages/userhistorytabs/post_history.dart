

import 'package:bennu_app/viewmodels/media_viewmodel.dart';
import 'package:bennu_app/widgets/grid_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class PostHistoryTab extends StatefulWidget {
  final String userId;

  const PostHistoryTab({Key? key, required this.userId}) : super(key: key);

  @override
  PostHistoryTabState createState() => PostHistoryTabState();
}

class PostHistoryTabState extends State<PostHistoryTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .where('userId', isEqualTo: widget.userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();

          var mediaList = snapshot.data!.docs
              .map((doc) => MediaViewModel.fromDocument(doc))
              .toList();

          return GridViewWidget(
            mediaList: mediaList,
            pageType: PageType.history,
          );
        },
      ),
    );
  }
}
