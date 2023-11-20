

// camera_tab.dart
import 'package:bennu_app/views/postpages/poststep2/video_editor_interface.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class CameraTab extends StatefulWidget {
  const CameraTab({super.key});

  @override
  CameraTabState createState() => CameraTabState();
}

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

  Future<void> _stopVideoRecording() async {
    if (!_controller!.value.isRecordingVideo) {
      return;
    }

    await _controller!.stopVideoRecording();
    _navigateToVideoEditor(_videoPath!);
  }

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
      body: Stack(
        children: [
          CameraPreview(_controller!),
          // Place any other widgets you want on top of the camera preview here
          // For example, a button to start and stop video recording
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

