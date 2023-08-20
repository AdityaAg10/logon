import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ViewRecordedVideo extends StatefulWidget {
  final String videoPath;

  ViewRecordedVideo({required this.videoPath, double? longitude, double? latitude});

  @override
  _ViewRecordedVideoState createState() => _ViewRecordedVideoState();
}

class _ViewRecordedVideoState extends State<ViewRecordedVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {
          // Ensure the first frame is shown
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Recorded Video')),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(), // Show loading indicator while initializing
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            _controller.play();
          }
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
