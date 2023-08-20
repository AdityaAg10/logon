import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:logon/pages/recording_screen.dart';

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
      appBar: AppBar(title: Text('Camera')),
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
