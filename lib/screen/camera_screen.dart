import 'dart:math';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:kodatel/main.dart';
import 'package:kodatel/screen/camera_view.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key, required this.sourceId, required this.chatWith})
      : super(key: key);
  final String sourceId;
  final String chatWith;
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> cameraValue;
  bool isVideoRecording = false;
  bool flash = false;
  bool front = true;
  double transform = 0;
  @override
  void initState() {
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: CameraPreview(_cameraController));
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        Positioned(
          bottom: 0.0,
          child: Container(
            color: Colors.black,
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          flash = !flash;
                        });
                        flash
                            ? _cameraController.setFlashMode(FlashMode.torch)
                            : _cameraController.setFlashMode(FlashMode.off);
                      },
                      icon: Icon(
                        flash ? Icons.flash_on : Icons.flash_off,
                        color: Colors.white,
                        size: 28,
                      )),
                  GestureDetector(
                      onLongPress: () async {
                        await _cameraController.startVideoRecording();
                        setState(() {
                          isVideoRecording = true;
                        });
                      },
                      onLongPressUp: () async {
                        String path =
                            (await _cameraController.stopVideoRecording()).path;
                        setState(() {
                          isVideoRecording = false;
                        });
                        _cameraController.dispose();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => CameraViewPage(
                                      path: path,
                                      isVideo: true,
                                      sourceId: widget.sourceId,
                                      chatWith: widget.chatWith,
                                    ))));
                      },
                      onTap: () {
                        if (!isVideoRecording) takePhoto(context);
                      },
                      child: isVideoRecording
                          ? const Icon(
                              Icons.radio_button_on,
                              color: Colors.red,
                              size: 70,
                            )
                          : const Icon(
                              Icons.panorama_fish_eye,
                              color: Colors.white,
                              size: 70,
                            )),
                  IconButton(
                      onPressed: () async {
                        setState(() {
                          front = !front;
                          transform += pi;
                        });
                        int cameraPos = front ? 0 : 1;
                        _cameraController = CameraController(
                            cameras[cameraPos], ResolutionPreset.high);
                        cameraValue = _cameraController.initialize();
                      },
                      icon: Transform.rotate(
                        angle: transform,
                        child: const Icon(
                          Icons.flip_camera_ios,
                          color: Colors.white,
                          size: 28,
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                "Hold for video,tap for photo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ]),
          ),
        )
      ]),
    );
  }

  void takePhoto(BuildContext context) async {
    String path = (await _cameraController.takePicture()).path;
    _cameraController.dispose();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CameraViewPage(
                  path: path,
                  isVideo: false,
                  sourceId: widget.sourceId,
                  chatWith: widget.chatWith,
                )));
  }
}
