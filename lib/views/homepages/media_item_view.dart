

// media_item_view.dart
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../viewmodels/media_viewmodel.dart';

// ステートフルウィジェットMediaItemViewを定義します。
class MediaItemView extends StatefulWidget {
  // このビューに対応するViewModelを保持します。
  final MediaViewModel viewModel;

  // コンストラクタで必要なパラメータを初期化します。
  // (注: 引数が正しく渡されていません。nullを渡すことはできません。)
  const MediaItemView({
    required this.viewModel,
    Key? key,
    required caption,
    required itemlimit,
    required postDate,
    required likes,
    required comments,
    required shares,
    required purchases,
    required media,
    required boxin
  }) : super(key: key);

  @override
  MediaItemViewState createState() => MediaItemViewState();
}

// MediaItemViewのステートクラスを定義します。
class MediaItemViewState extends State<MediaItemView> {
  // VideoPlayerControllerを初期化します。
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // VideoPlayerControllerを使用して、viewModel内のvideoUrlから動画を再生します。
    _controller = VideoPlayerController.network(widget.viewModel.videoUrl)
      ..initialize().then((_) {
        setState(() {
          // 動画の初期化が完了したら再生を開始します。
          _controller.play();
        });
      });
  }

  @override
  void dispose() {
    // ウィジェットが破棄される時に、コントローラーを破棄します。
    super.dispose();
    _controller.dispose();
  }

  // 動画を再生するメソッドです。
  void play() {
    if (!_controller.value.isInitialized) return;
    _controller.play();
  }

  // 動画を一時停止するメソッドです。
  void pause() {
    if (!_controller.value.isInitialized) return;
    _controller.pause();
  }

  @override
  Widget build(BuildContext context) {
    // スタックレイアウトを使用して、動画プレーヤーとその他のUI要素を配置します。
    return Stack(
      children: [
        // Video Playerウィジェット
        Positioned.fill(
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
        ),
        // ... その他のUI要素
      ],
    );
  }
}

// MediaReelは、複数のMediaViewModelを持つページビューを定義します。
class MediaReel extends StatefulWidget {
  final List<MediaViewModel> viewModels;

  const MediaReel({Key? key, required this.viewModels}) : super(key: key);

  @override
  MediaReelState createState() => MediaReelState();
}

// MediaReelのステートクラスを定義します。
class MediaReelState extends State<MediaReel> {
  // 各メディアアイテムビューのためのキーのリストを保持します。
  final List<GlobalKey<MediaItemViewState>> _keys = [];

  @override
  void initState() {
    super.initState();
    // ViewModelの数だけキーを生成してリストに追加します。
    for (var _ in widget.viewModels) {
      _keys.add(GlobalKey<MediaItemViewState>());
    }
  }

  @override
  Widget build(BuildContext context) {
    // PageView.builderを使用して、メディアアイテムビューをスクロール可能なリストとして表示します。
    return PageView.builder(
      itemCount: widget.viewModels.length,
      itemBuilder: (context, index) {
        // VisibilityDetectorを使用して、アイテムの可視性に応じて動画の再生と一時停止を制御します。
        return VisibilityDetector(
          key: Key('video-$index'),
          onVisibilityChanged: (visibilityInfo) {
            final visiblePercentage = visibilityInfo.visibleFraction * 100;
            if (visiblePercentage > 50) {
              _keys[index].currentState?.play();
            } else {
              _keys[index].currentState?.pause();
            }
          },
          // コンストラクタの引数が不適切です。実際のパラメータを渡す必要があります。
          child: MediaItemView(viewModel: widget.viewModels[index], key: _keys[index], caption: null, itemlimit: null, postDate: null, likes: null, comments: null, shares: null, purchases: null, media: null, boxin: null,),
        );
      },
    );
  }
}
