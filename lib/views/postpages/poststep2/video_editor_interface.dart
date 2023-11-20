

// video_editor_interface.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tapioca/tapioca.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class VideoEditorInterface extends StatefulWidget {
  final XFile videoFile;
  final String purchaseId;
  final String videoUrl; // String型のURL

  const VideoEditorInterface({super.key, required this.videoFile, required this.videoUrl, required this.purchaseId});

  @override
  VideoEditorInterfaceState createState() => VideoEditorInterfaceState();
}

class VideoEditorInterfaceState extends State<VideoEditorInterface> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoFile.path))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> editVideo() async {
    final tapiocaBalls = [
      TapiocaBall.textOverlay("Hello Flutter!", 100, 10, 100, const Color(0xffffc0cb)),
      // 他のエフェクトもここに追加
    ];
    final tempDir = await getTemporaryDirectory();
    final outputPath = '${tempDir.path}/result.mp4';
    final cup = Cup(Content(widget.videoFile.path), tapiocaBalls);

    await cup.suckUp(outputPath).then((_) {
      // 編集が完了したら、投稿ページのリストに遷移する。
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller != null && _controller!.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            )
          : Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: editVideo,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
