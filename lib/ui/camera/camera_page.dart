import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:video_player/video_player.dart';

late List<CameraDescription> _cameras;

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late CameraController camController;
  bool isFlashVisible = false;

  XFile? imageFile;
  XFile? videoFile;
  VideoPlayerController? videoController;
  VoidCallback? videoPlayerListener;
  bool enableAudio = true;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _currentExposureOffset = 0.0;
  late AnimationController _flashModeControlRowAnimationController;
  late Animation<double> _flashModeControlRowAnimation;
  late AnimationController _exposureModeControlRowAnimationController;
  late Animation<double> _exposureModeControlRowAnimation;
  late AnimationController _focusModeControlRowAnimationController;
  late Animation<double> _focusModeControlRowAnimation;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentScale = 1.0;
  double _baseScale = 1.0;
  int _pointers = 0;
  // the tap location
  Offset? _tapPosition;
  final GlobalKey _cameraKey = GlobalKey();
  double camViewX = 0;
  double camViewY = 0;
  List<Map> markBiopsyPos = [];

  Future<void> camInit() async {
    _cameras = await availableCameras();
  }

  void onSetFlashModeButtonPressed(FlashMode mode) {
    setFlashMode(mode).then((_) {
      if (mounted) {
        setState(() {});
      }
      showInSnackBar('Flash mode set to ${mode.toString().split('.').last}');
    });
  }

  Future<void> setFlashMode(FlashMode mode) async {
    if (camController == null) {
      return;
    }

    try {
      await camController!.setFlashMode(mode);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _showCameraException(CameraException e) {
    _logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  void _logError(String code, String? message) {
    // ignore: avoid_print
    print('Error: $code${message == null ? '' : '\nError Message: $message'}');
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    if (camController != null) {
      return camController!.setDescription(cameraDescription);
    } else {
      return _initializeCameraController(cameraDescription);
    }
  }

  Future<void> _initializeCameraController(
      CameraDescription cameraDescription) async {
    final CameraController cameraController = CameraController(
      cameraDescription,
      kIsWeb ? ResolutionPreset.max : ResolutionPreset.medium,
      enableAudio: enableAudio,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    camController = cameraController;

    // If the camController is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        showInSnackBar(
            'Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
      await Future.wait(<Future<Object?>>[
        // The exposure mode is currently not supported on the web.
        ...!kIsWeb
            ? <Future<Object?>>[
                cameraController.getMinExposureOffset().then(
                    (double value) => _minAvailableExposureOffset = value),
                cameraController
                    .getMaxExposureOffset()
                    .then((double value) => _maxAvailableExposureOffset = value)
              ]
            : <Future<Object?>>[],
        cameraController
            .getMaxZoomLevel()
            .then((double value) => _maxAvailableZoom = value),
        cameraController
            .getMinZoomLevel()
            .then((double value) => _minAvailableZoom = value),
      ]);
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          showInSnackBar('You have denied camera access.');
          break;
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          showInSnackBar('Please go to Settings app to enable camera access.');
          break;
        case 'CameraAccessRestricted':
          // iOS only
          showInSnackBar('Camera access is restricted.');
          break;
        case 'AudioAccessDenied':
          showInSnackBar('You have denied audio access.');
          break;
        case 'AudioAccessDeniedWithoutPrompt':
          // iOS only
          showInSnackBar('Please go to Settings app to enable audio access.');
          break;
        case 'AudioAccessRestricted':
          // iOS only
          showInSnackBar('Audio access is restricted.');
          break;
        default:
          _showCameraException(e);
          break;
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _getTapPosition(TapDownDetails details) async {
    final tapPosition = details.globalPosition;
    setState(() {
      _tapPosition = tapPosition;
      markBiopsyPos.add({'x': posX(), 'y': posY()});
      print(markBiopsyPos.last);
    });
  }

  void _getCameraViewPosition(_) {
    final RenderBox renderBox =
        _cameraKey.currentContext?.findRenderObject() as RenderBox;
    _cameraKey.currentContext?.size;

    final Size size = renderBox.size;

    final Offset offset = renderBox.globalToLocal(Offset.zero);
    print('Size: ${size.width}, ${size.height}');
    print('Offset: ${offset.dx}, ${offset.dy}');
    print(
        'Position: ${(offset.dx + size.width) / 2}, ${(offset.dy + size.height) / 2}');
    camViewX = -offset.dx;
    camViewY = -offset.dy;
  }

  double posX() {
    double tapX = _tapPosition?.dx ?? 0.0;
    double posX = tapX - camViewX;
    return posX;
  }

  double posY() {
    double tapY = _tapPosition?.dy ?? 0.0;
    double posY = tapY - camViewY;
    return posY;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_getCameraViewPosition);
    camInit();
    camController = CameraController(_cameras[0], ResolutionPreset.max);
    camController.initialize().then(
      (_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      },
    ).catchError(
      (Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              // Handle access errors here.
              break;
            default:
              // Handle other errors here.
              break;
          }
        }
      },
    );
    WidgetsBinding.instance.addObserver(this);

    _flashModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _flashModeControlRowAnimation = CurvedAnimation(
      parent: _flashModeControlRowAnimationController,
      curve: Curves.easeInCubic,
    );
  }

  @override
  void dispose() {
    camController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(child: SizedBox()),
                GestureDetector(
                  onTapDown: (details) {
                    _getTapPosition(details);
                  },
                  child: Stack(
                    children: [
                      Container(
                        key: _cameraKey,
                        child: CameraPreview(camController),
                      ),
                      for (var mark in markBiopsyPos)
                        Positioned(
                          top: mark['y'],
                          left: mark['x'],
                          child: Container(
                            height: 30,
                            width: 30,
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(child: SizedBox()),
              ],
            ),
            Column(
              children: [
                //button-button atas
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.flash_on_outlined,
                            color: Color.fromARGB(255, 243, 243, 240)),
                        onPressed: () => setState(() {
                          isFlashVisible = !isFlashVisible;
                        }),
                        color: Colors.white,
                      ),
                      Icon(Icons.exposure, color: Colors.white),
                      Icon(Icons.contrast,
                          color: Color.fromARGB(255, 248, 154, 154)),
                    ],
                  ),
                ),
                Visibility(
                  visible: isFlashVisible,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.flash_off),
                        color: camController.value.flashMode == FlashMode.off
                            ? Colors.orange
                            : Colors.white,
                        onPressed: camController != null
                            ? () => onSetFlashModeButtonPressed(FlashMode.off)
                            : null,
                      ),
                      IconButton(
                        icon: const Icon(Icons.flash_auto),
                        color: camController.value.flashMode == FlashMode.auto
                            ? Colors.orange
                            : Colors.white,
                        onPressed: camController != null
                            ? () => onSetFlashModeButtonPressed(FlashMode.auto)
                            : null,
                      ),
                      IconButton(
                        icon: const Icon(Icons.flash_on),
                        color: camController.value.flashMode == FlashMode.always
                            ? Colors.orange
                            : Colors.white,
                        onPressed: camController != null
                            ? () =>
                                onSetFlashModeButtonPressed(FlashMode.always)
                            : null,
                      ),
                      IconButton(
                        icon: const Icon(Icons.highlight),
                        color: camController.value.flashMode == FlashMode.torch
                            ? Colors.orange
                            : Colors.white,
                        onPressed: camController != null
                            ? () => onSetFlashModeButtonPressed(FlashMode.torch)
                            : null,
                      )
                    ],
                  ),
                ),
                Expanded(child: SizedBox()),
                //button-button bawah
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () =>
                            camController.description == _cameras[0]
                                ? onNewCameraSelected(_cameras[1])
                                : onNewCameraSelected(_cameras[0]),
                        icon: Icon(Icons.camera_front, color: Colors.white),
                      ),
                      Icon(Icons.exposure, color: Colors.white),
                      Icon(Icons.contrast, color: Colors.white),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    // Add your button functionality here
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
