

// media_item_view.dart
import 'package:bennu_app/widgets/buttonwidgets/like_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../viewmodels/media_viewmodel.dart';

// ステートフルウィジェットMediaItemViewを定義します。
class MediaItemView extends StatefulWidget {
  // このビューに対応するViewModelを保持します。
  final MediaViewModel viewModel;
  const MediaItemView({
    required this.viewModel,
    Key? key,
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
        // 動画の上に重ねるUIを配置します。
      // 現在は一旦、動画の右下に「いいね」ボタンを配置してみる。
        Positioned(
          right: 10,
          bottom: 10,
          child: LikeButtonWidget(
            postId: widget.viewModel.postId, // ViewModelからpostIdを取得
            userId: widget.viewModel.userId, // ViewModelからuserIdを取得
          ),
        ),
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
        // 現在のViewModelを取得
        final viewModel = widget.viewModels[index];

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
          child: MediaItemView(
            key: _keys[index],
            viewModel: viewModel,
          ),
        );
      },
    );
  }
}
