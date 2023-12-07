


import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../viewmodels/media_viewmodel.dart';
import '../views/homepages/media_item_view.dart';

enum PageType {
  history, likes, purchase, search, cart, relay
}

class GridViewWidget extends StatelessWidget {
  final List<MediaViewModel> mediaList;
  final PageType pageType;
  final Widget Function(MediaViewModel)? customItemBuilder; 
  final Widget? bottomNavigationBar;

  const GridViewWidget({
    Key? key,
    required this.mediaList,
    required this.pageType,
    this.customItemBuilder,
    this.bottomNavigationBar,
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
          child: customItemBuilder != null
          ? customItemBuilder!(mediaItem)
          : buildDefaultGridItem(mediaItem),
        );
      },
    );
  }

  Widget buildDefaultGridItem(MediaViewModel mediaItem) {
    return Column(
      children: [
        VideoPlayerWidget(videoUrl: mediaItem.videoUrl),
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

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  VideoPlayerWidgetState createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : const CircularProgressIndicator();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
