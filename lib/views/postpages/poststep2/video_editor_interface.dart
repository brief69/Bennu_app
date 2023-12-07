import 'dart:io';
import 'package:bennu/views/postpages/poststep3/post_tab.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tapioca/tapioca.dart';
import 'effect_settings.dart';
import 'video_control_buttons.dart';

class VideoEditorInterface extends StatefulWidget {
  final XFile videoFile;
  final String purchaseId;
  final String videoUrl;

  const VideoEditorInterface({super.key, required this.videoFile, required this.videoUrl, required this.purchaseId});

  @override
  VideoEditorInterfaceState createState() => VideoEditorInterfaceState();
}

class VideoEditorInterfaceState extends State<VideoEditorInterface> {
  VideoPlayerController? _controller;
  bool _isEditing = false;
  final EffectSettings _effectSettings = EffectSettings();

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
    setState(() {
      _isEditing = true;
    });

    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      final tapiocaBalls = _createTapiocaBalls();
      final tempDir = await getTemporaryDirectory();
      final outputPath = '${tempDir.path}/result.mp4';
      final cup = Cup(Content(widget.videoFile.path), tapiocaBalls);

      await cup.suckUp(outputPath).then((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PostTab(videoData: File(outputPath), userId: '',)),
        );
      });
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Error editing video: $e')),
      );
    } finally {
      setState(() {
        _isEditing = false;
      });
    }
  }

  List<TapiocaBall> _createTapiocaBalls() {
    return [
      TapiocaBall.textOverlay(
        _effectSettings.textOverlay,
        _effectSettings.textPosition.dx.toInt(),
        _effectSettings.textPosition.dy.toInt(),
        _effectSettings.fontSize.toInt(),
        _effectSettings.textColor,
      ),
      // 他のエフェクト
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Video')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _controller != null && _controller!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  )
                : const CircularProgressIndicator(),
          ),
          VideoControlButtons(controller: _controller),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isEditing ? null : editVideo,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
