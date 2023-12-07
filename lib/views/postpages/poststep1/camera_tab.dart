import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import '/views/postpages/poststep2/video_editor_interface.dart';

// カメラタブのウィジェットを定義するクラス
class CameraTab extends StatefulWidget {
  const CameraTab({super.key});

  @override
  CameraTabState createState() => CameraTabState();
}

// カメラタブの状態を管理するクラス
class CameraTabState extends State<CameraTab> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  String? _videoPath;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  // カメラを初期化するメソッド
  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras!.isNotEmpty) {
      _controller = CameraController(
        _cameras!.first,
        ResolutionPreset.medium,
        enableAudio: true,
      );

      _controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {
          _isCameraInitialized = true;
        });
      });
    }
  }

  // ビデオ録画を開始するメソッド
  Future<void> _startVideoRecording() async {
    if (!_controller!.value.isInitialized) {
      return;
    }

    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final String videoDirectory = '${appDirectory.path}/Videos';
    await Directory(videoDirectory).create(recursive: true);
    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    _videoPath = '$videoDirectory/$currentTime.mp4';

    await _controller!.startVideoRecording();
    }

  // ビデオ録画を停止するメソッド
  Future<void> _stopVideoRecording() async {
    if (!_controller!.value.isRecordingVideo) {
      return;
    }

    await _controller!.stopVideoRecording();
    _navigateToVideoEditor(_videoPath!);
  }

  // ビデオエディタに遷移するメソッド
  void _navigateToVideoEditor(String videoPath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoEditorInterface(videoFile: XFile(videoPath), purchaseId: '', videoUrl: '',),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // AppBarを透明に設定
        elevation: 0, // 影をなくす
        leading: IconButton(
          icon: const Icon(Icons.close), // バツボタン
          onPressed: () {
            Navigator.pop(context); // PostTabModalを閉じる
          }
        )
      ),
      body: Stack(
        children: [
          CameraPreview(_controller!),
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller!.value.isRecordingVideo) {
            _stopVideoRecording();
          } else {
            _startVideoRecording();
          }
        },
        child: Icon(
          _controller!.value.isRecordingVideo ? Icons.stop : Icons.videocam,
        ),
      ),
    );
  }
}

