import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue, // Customize your app's primary color
        hintColor: Colors.green, // Customize your app's accent color
        fontFamily: 'Roboto', // Use your desired font family
      ),
      home: cameras.isEmpty ? CircularProgressIndicator() : CameraApp(cameras: cameras),
    ),
  );
}

class CameraApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  CameraApp({required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Adjust theme as needed
      home: CameraScreen(cameras: cameras),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  CameraScreen({required this.cameras});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the camera
    _controller = CameraController(
      widget.cameras[0], // Use the first available camera
      ResolutionPreset.medium,
    );

    // Start the camera
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Add settings functionality here
            },
          ),
        ],
      ),
      body: Center(
        child: CameraPreview(_controller),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the recording screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecordingScreen(controller: _controller),
            ),
          );
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}

class RecordingScreen extends StatefulWidget {
  final CameraController controller;

  RecordingScreen({required this.controller});

  @override
  _RecordingScreenState createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  bool isRecording = true; // Track if recording is in progress

  late String videoPath; // Path to the recorded video

  @override
  void initState() {
    super.initState();
    // Start video recording
    widget.controller.startVideoRecording().then((value) {
      setState(() {
        isRecording = true;
      });
    });
  }

  void stopRecordingAndNavigateToView() async {
    // Stop video recording
    XFile videoFile = await widget.controller.stopVideoRecording();
    setState(() {
      isRecording = false;
      videoPath = videoFile.path; // Save the path to the recorded video
    });

    // Navigate to the view recording page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewRecordedVideo(videoPath: videoPath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recording'),
        actions: [
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              // Add cancel recording functionality here
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align children at the bottom
        children: <Widget>[
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CameraPreview(widget.controller), // Display camera preview
                Positioned(
                  top: 0, // Adjust the position as needed
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (isRecording)
                        Icon(
                          Icons.fiber_manual_record,
                          color: Colors.red,
                          size: 48,
                        ),
                      if (isRecording)
                        Text(
                          'Recording in progress...',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (!isRecording)
                        Text(
                          'Recording stopped.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: stopRecordingAndNavigateToView,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.stop, size: 24),
                  SizedBox(width: 8),
                  Text(
                    'Stop Recording',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ViewRecordedVideo extends StatefulWidget {
  final String videoPath;

  ViewRecordedVideo({required this.videoPath});

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
      appBar: AppBar(
        title: Text('View Recorded Video'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Add share functionality here
            },
          ),
        ],
      ),
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
