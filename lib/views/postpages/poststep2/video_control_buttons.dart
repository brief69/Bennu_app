import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoControlButtons extends StatelessWidget {
  final VideoPlayerController? controller;

  const VideoControlButtons({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: () {
            // 再生ボタンが押された時の処理
            if (!controller!.value.isPlaying) {
              controller!.play();
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.pause),
          onPressed: () {
            // 一時停止ボタンが押された時の処理
            if (controller!.value.isPlaying) {
              controller!.pause();
            }
          },
        ),
        // 必要に応じて他のコントロールボタンを追加
        // 例えば、巻き戻しや早送りなど
      ],
    );
  }
}
