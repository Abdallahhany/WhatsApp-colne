import 'dart:math';
import 'package:camera/camera.dart';
import 'package:chatapp/screens/videoView.dart';
import 'package:flutter/material.dart';
import 'cameraView.dart';

List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController _cameraController;
  Future<void> cameraValue;
  bool isRecording = false;
  bool flash = false;
  bool frontCamera = true;
  double transform = 0;
  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CameraPreview(_cameraController)
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Positioned(
            bottom: 0,
            child: Container(
              // padding: EdgeInsets.only(top: 5, bottom: 5),
              // color: Colors.black,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon:flash ? Icon(Icons.flash_on) : Icon(Icons.flash_off),
                        onPressed: () {
                          setState(() {
                            flash =! flash;
                          });
                          flash ? _cameraController.setFlashMode(FlashMode.torch)
                              : _cameraController.setFlashMode(FlashMode.off) ;
                        },
                        color: Colors.white,
                        iconSize: 35.0,
                      ),
                      GestureDetector(
                        child: isRecording
                            ? Icon(
                                Icons.radio_button_on,
                                color: Colors.red,
                                size: 70.0,
                              )
                            : Icon(
                                Icons.panorama_fish_eye,
                                color: Colors.white,
                                size: 70.0,
                              ),
                        onTap: () {
                          if (!isRecording) takePhoto(context);
                        },
                        onLongPress: () async {
                          await _cameraController.startVideoRecording();
                          setState(() {
                            isRecording = true;
                          });
                        },
                        onLongPressUp: () async {
                          XFile videoPath =
                              await _cameraController.stopVideoRecording();
                          setState(() {
                            isRecording = false;
                          });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (builder) => VideoViewPage(
                                    path: videoPath.path,
                                  )));
                        },
                      ),
                      IconButton(
                        icon: Transform.rotate(
                          angle: transform,
                            child: Icon(Icons.flip_camera_ios)
                        ),
                        onPressed: () {
                          int cameraPos = frontCamera ? 0 : 1;
                          setState(() {
                            frontCamera =! frontCamera;
                            transform += pi;
                          });
                          _cameraController = CameraController(
                              cameras[cameraPos], ResolutionPreset.high
                          );
                          cameraValue = _cameraController.initialize();

                        },
                        color: Colors.white,
                        iconSize: 35.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Hold for Video, tap for photo",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    XFile file = await _cameraController.takePicture();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (builder) => CameraViewPage(
              path: file.path,
            )));
  }
}
