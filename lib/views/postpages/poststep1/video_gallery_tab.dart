import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '/views/postpages/poststep2/video_editor_interface.dart';

class VideoGalleryTab extends StatefulWidget {
  const VideoGalleryTab({super.key});

  @override
  VideoGalleryTabState createState() => VideoGalleryTabState();
}

class VideoGalleryTabState extends State<VideoGalleryTab> {
  List<XFile>? videos;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedVideos = await picker.pickMultiImage();
    setState(() {
      videos = pickedVideos;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 
    return Scaffold(
      appBar: AppBar(
        title: Text('動画をアップロード', style: theme.textTheme.titleLarge),
        backgroundColor: theme.appBarTheme.backgroundColor, 
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: videos == null
          ? const Center(child: Text('ビデオがありません。'))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: videos!.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoEditorInterface(
                          videoFile: videos![index], 
                          purchaseId: '', 
                          videoUrl: '',),
                      ),
                    );
                  },
                  child: Image.file(File(videos![index].path), fit: BoxFit.cover),
                );
              },
            ),
    );
  }
}
