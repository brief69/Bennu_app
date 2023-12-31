import 'package:bennu/widgets/actionwidgets/berry_pay_widget.dart';
import 'package:bennu/widgets/homebuttonwidgets/like_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../viewmodels/media_viewmodel.dart';
import '../../widgets/homebuttonwidgets/buy_button_widget.dart';
import '../../widgets/homebuttonwidgets/caption_button_widget.dart';
import '../../widgets/homebuttonwidgets/incart_button_widget.dart';
import '../../widgets/homebuttonwidgets/other_button_widget.dart';
import '../../widgets/homebuttonwidgets/price_button_widget.dart';
import '../../widgets/homebuttonwidgets/relay_button_widget.dart';
import '../../widgets/homebuttonwidgets/share_button_widget.dart';
import '../../widgets/homebuttonwidgets/stock_button_widget.dart';
import '../../widgets/homebuttonwidgets/usericon_button_widget.dart';

class MediaItemView extends StatefulWidget {
  final MediaViewModel viewModel;
  const MediaItemView({
    required this.viewModel,
    Key? key, required UserProfile receiverProfile, required UserProfile senderProfile,
  }) : super(key: key);

  @override
  MediaItemViewState createState() => MediaItemViewState();
}
class MediaItemViewState extends State<MediaItemView> {
  late VideoPlayerController _controller;
  
  get receiverProfileInstance => null;
  get senderProfileInstance => null; //　初期化

  @override
  void initState() {
    super.initState();
    // VideoPlayerControllerを使用して、viewModel内のvideoUrlから動画を再生します。
    // ignore: deprecated_member_use
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
        // UserIconWidgetの配置
        Positioned(
          top: 16, // 上部からの距離
          right: 16, // 右側からの距離
          child: UserIconWidget(
            userProfileUrl: 'ユーザーのプロフィールURL',
            onFollow: () {
            // フォロー処理
            },
            onProfileTap: () {
            // プロフィールタップ処理
            },
          ),
        ),
        // LikeButtonWidgetの配置
        const Positioned(
          top: 100, // UserIconWidgetの下に配置するための適切な高さ
          right: 16, // 右側からの距離
          child: LikeButtonWidget(
            postId: '',
            userId: 'ユーザーID',
          ),
        ),
        Positioned(
          top: 160, // LikeButtonWidgetの下に配置するための適切な高さ
          right: 16, // 右側からの距離
          child: IconButton(
            icon: const Icon(Icons.comment),
            onPressed: () {
            // コメントセクションを開く処理
            },
          ),
        ),
        // OtherWidgetの配置
        const Positioned(
          top: 220, // CommentIconButtonの下に配置するための適切な高さ
          right: 16, // 右側からの距離
          child: OtherWidget(),
        ),
        // BuyButtonの配置
        Positioned(
          top: 280, // OtherWidgetの下に配置するための適切な高さ
          right: 16, // 右側からの距離
          child: BuyButton(
            price: '価格', 
            isExtendedByDefault: true,  // 必要に応じて指定
            receiverProfile: receiverProfileInstance,  // UserProfile型のインスタンス
            senderProfile: senderProfileInstance,  // UserProfile型のインスタンス
          ),
        ),
        // InCartWidgetの配置
        const Positioned(
          top: 340, 
          right: 16,
          child: InCartWidget(
            productId: '商品ID',
            stock: 0,
            initialInCart: 0, 
            postId: '',
          ),
        ),
        // ShareWidgetの配置
        const Positioned(
          top: 400, // InCartWidgetの下に配置するための適切な高さ
          right: 16, // 右側からの距離
          child: ShareWidget(
            textToShare: '共有したいテキスト',
            subject: '任意のサブジェクト',
          ),
        ),
        // RelayWidgetの配置
        const Positioned(
          bottom: 16,
          right: 60,
          child: RelayWidget(),
        ),
        // PriceWidgetの配置
        const Positioned(
          bottom: 16,
          right: 120,
          child: PriceWidget(
            priceInYen: 0,
          ),
        ),
        // StockWidgetの配置
        const Positioned(
          bottom: 16, // 下部からの距離
          right: 180, // PriceWidgetの左側に配置
          child: StockWidget(
            stockCount: 5, // 例：在庫数5
          ),
        ),
        // CaptionButtonWidgetの配置
        const Positioned(
          bottom: 80, // ボタンの上に配置するための適切な高さ
          right: 20, // 右側からの距離
          left: 20, // 左側からの距離
          child: CaptionButtonWidget(
            caption: 'ここにキャプションのテキストを挿入',
          ),
        ),
      ],
    );
  }
}

// MediaReelは、複数のMediaViewModelを持つpageviewを定義
class MediaReel extends StatefulWidget {
  final List<MediaViewModel> viewModels;

  const MediaReel({Key? key, required this.viewModels}) : super(key: key);

  @override
  MediaReelState createState() => MediaReelState();
}

// MediaReelのステートクラスを定義します。
class MediaReelState extends State<MediaReel> {
  final List<GlobalKey<MediaItemViewState>> _keys = [];
  
  get receiverProfileInstance => null;
  
  get senderProfileInstance => null;

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
            viewModel: viewModel, senderProfile: senderProfileInstance, receiverProfile: receiverProfileInstance,
          ),
        );
      },
    );
  }
}
