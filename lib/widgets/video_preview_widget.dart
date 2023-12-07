import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class VideoPreviewWidget extends StatefulWidget {
  final File videoFile;

  const VideoPreviewWidget({Key? key, required this.videoFile}) : super(key: key);

  @override
  VideoPreviewWidgetState createState() => VideoPreviewWidgetState();
}

class VideoPreviewWidgetState extends State<VideoPreviewWidget> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: _controller != null && _controller!.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            )
          : const CircularProgressIndicator(),
    );
  }
}
