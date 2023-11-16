

// grid_view_widget.dart
import 'package:flutter/material.dart';
import '../viewmodels/media_viewmodel.dart';
import '../views/homepages/media_item_view.dart';

enum PageType {
  history, likes, purchase, search, cart
}

class GridViewWidget extends StatelessWidget {
  final List<MediaViewModel> mediaList;
  final PageType pageType;

  const GridViewWidget({
    Key? key,
    required this.mediaList,
    required this.pageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: mediaList.length,
      itemBuilder: (context, index) {
        final mediaItem = mediaList[index];
        return GestureDetector(
          onTap: () => navigateToMediaPage(context, mediaItem),
          child: buildGridItem(mediaItem),
        );
      },
    );
  }

  Widget buildGridItem(MediaViewModel mediaItem) {
    return Column(
      children: [
        Image.network(mediaItem.videoUrl), // 動画のサムネイル表示
        // 他の共通UI要素（例：キャプションやいいね数の表示）
        Text(mediaItem.caption),
        // ... その他の情報表示
      ],
    );
  }

  void navigateToMediaPage(BuildContext context, MediaViewModel mediaItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MediaReel(viewModels: [mediaItem]),
      ),
    );
  }
}
