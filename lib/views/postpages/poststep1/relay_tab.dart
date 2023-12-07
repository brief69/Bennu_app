import 'package:bennu/viewmodels/post_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '/views/postpages/poststep2/video_editor_interface.dart';
import '/viewmodels/media_viewmodel.dart';
import '/widgets/grid_view_widget.dart';


class RepostTab extends StatelessWidget {
  final String userId;
  final TextEditingController captionController = TextEditingController();
  final TextEditingController changeNotesController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  RepostTab({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('RePost', style: theme.textTheme.titleLarge),
        backgroundColor: theme.appBarTheme.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        )
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
              customItemBuilder: (mediaItem) {
                return InkWell(
                  onTap: () {
                    captionController.text = mediaItem.caption;
                    priceController.text = mediaItem.price.toString();
                    stockController.text = mediaItem.stock.toString();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoEditorInterface(
                          videoFile: XFile(mediaItem.videoUrl),
                          purchaseId: mediaItem.id,
                          videoUrl: mediaItem.videoUrl,
                        ),
                      )
                    );
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Text(mediaItem.caption),
                        // 他のメディア情報を表示
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Text('No purchase history found.');
          }
        },
      ),
      floatingActionButton: Consumer(
        builder: (context, ref, _) {
          final postViewModel = ref.watch(postViewModelProvider.notifier);

          bool isFormFilled = captionController.text.isNotEmpty &&
                              priceController.text.isNotEmpty &&
                              stockController.text.isNotEmpty &&
                              changeNotesController.text.isNotEmpty;

          return FloatingActionButton(
            onPressed: isFormFilled ? () async {
              final caption = captionController.text;
              final price = double.tryParse(priceController.text) ?? 0.0;
              final stock = int.tryParse(stockController.text) ?? 0;
              final changeNotes = changeNotesController.text;

              // Firestoreにリポストデータを保存する処理
              await postViewModel.repost(
                caption: caption,
                price: price,
                stock: stock,
                changeNotes: changeNotes,
                // 他に必要な情報を追加
              );

              // ignore: use_build_context_synchronously
              Navigator.pop(context); // ホーム画面に戻る
            } : null,
            backgroundColor: isFormFilled ? Theme.of(context).primaryColor : Colors.grey,
            child: const Icon(Icons.replay),
          );
        },
      ),
    );
  }
}
