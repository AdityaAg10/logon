import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:logon/pages/recording_screen.dart';

void runAppWithCameras() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: cameras.isEmpty ? CircularProgressIndicator() : CameraApp(cameras: cameras),
    ),
  );
}
