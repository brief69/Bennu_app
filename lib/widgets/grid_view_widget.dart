

// grid_view_widget.dart
import 'package:flutter/material.dart';
import '../viewmodels/media_viewmodel.dart';


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
    // ここでページタイプに基づいて異なるUIを表示する
    // 例：カートページでは価格とカウンターを表示
    return Column(
      children: [
        Image.network(mediaItem.videoUrl), // 動画のサムネイル表示
        if (pageType == PageType.cart) ...[
          Text('${mediaItem.price}円'),
          // 数量調整のためのカウンターを表示するコード
        ],
        // 他の共通UI要素
      ],
    );
  }

  void navigateToMediaPage(BuildContext context, MediaViewModel mediaItem) {
    // グリッドアイテムをタップしたときのナビゲーションロジック
    // 例：Navigator.push(...)
  }
}
