import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:wallet_apps/index.dart';

List<CameraDescription> cameras = [];

class CameraApp extends StatefulWidget {

  final int? index;

  CameraApp({this.index});

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> with WidgetsBindingObserver {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  int index = 0;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    initCamera();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  // @override
  // void dispose() {
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.landscapeRight,
  //     DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]);
  //   _controller.dispose();
  //   super.dispose();
  // }

  initCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      cameras[0],
      // Define the resolution to use.
      ResolutionPreset.max,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);  
    setState(() {
      
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
SystemChrome.setPreferredOrientations(orientation == Orientation.portrait
    ? [
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ]
    : [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the preview.
          return Stack(
            children: [
              CameraPreview(_controller),
              Positioned(
                left: 0,
                bottom: paddingSize,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      Expanded(child: Container()),
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(CircleBorder()),
                            padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                            backgroundColor: MaterialStateProperty.all(Colors.white), // <-- Button color
                            overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                              if (states.contains(MaterialState.pressed)) return Colors.red; // <-- Splash color
                            }),
                          ),
                          // Provide an onPressed callback.
                          onPressed: () async {
                            // Take the Picture in a try / catch block. If anything goes wrong,
                            // catch the error.
                            try {
                              // Ensure that the camera is initialized.
                              await _initializeControllerFuture;

                              // Attempt to take a picture and get the file `image`
                              // where it was saved.
                              XFile image = await _controller.takePicture();

                              // If the picture was taken, display it on a new screen.
                              Navigator.pop(context, image);
                            } catch (e) {
                              // If an error occurs, log the error to the console.
                              print(e);
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                              height: 60, width: 60,
                              color: Colors.grey[400],
                            ),
                          ),
                        )
                      ),

                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.transparent)
                          ),
                          // Provide an onPressed callback.
                          onPressed: () async {
                            try {
                              index = index == 0 ? 1 : 0;
                              _controller = CameraController(
                                // Get a specific camera from the list of available cameras.
                                cameras[index],
                                // Define the resolution to use.
                                ResolutionPreset.max,
                              );

                              // If the picture was taken, display it on a new screen.
                              // Navigator.pop(context, image.path);
                              /// Reinit camera.
                              _initializeControllerFuture = _controller.initialize();
                              setState(() {
                                
                              });
                            } catch (e) {
                              // If an error occurs, log the error to the console.
                              print(e);
                            }
                          },
                          child: Icon(Icons.flip_camera_ios_outlined, size: 40),
                        )
                      )
                    ],
                  )
                ),
              )
            ]
          );
        } else {
          // Otherwise, display a loading indicator.
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
