import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:ultralytics_yolo/ultralytics_yolo.dart';
import 'package:ultralytics_yolo/yolo_model.dart';
import 'package:water_pathogen_detection_system/commonUtils/Constancts.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class PictureScreen extends StatefulWidget {
  final Uint8List? image;
  final File? selectedImage;

  const PictureScreen({Key? key, this.image, this.selectedImage})
      : super(key: key);

  @override
  State<PictureScreen> createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  late ObjectDetector _objectDetector;
  List<dynamic> _results = [];

  @override
  void initState() {
    super.initState();
    loadModel().then((_) {
      print("Model loaded successfully");
    }).catchError((error) {
      print("Error loading model: $error");
    });
  }

  Future<void> loadModel() async {
    final modelPath = await _copy('assets/best_int8.tflite');
    final metadataPath = await _copy('assets/metadata.yaml');
    final model = LocalYoloModel(
      id: '',
      task: Task.detect,
      format: Format.tflite,
      modelPath: modelPath,
      metadataPath: metadataPath,
    );

    _objectDetector = ObjectDetector(model: model);
    await _objectDetector.loadModel();
  }

  Future<String> _copy(String assetPath) async {
    final path = '${(await getApplicationSupportDirectory()).path}/$assetPath';
    await io.Directory(dirname(path)).create(recursive: true);
    final file = io.File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(assetPath);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }

  Future<void> imageClassification(String imagepath) async {
    try {
      print("Prediction started");
      final res = await _objectDetector.detect(imagePath: imagepath);
      setState(() {
        _results = res!;
        print("Prediction: $res");
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [primaryColor, secondaryColor]),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  widget.image != null
                      ? Container(
                          width: 350,
                          height: 500,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(widget.image!),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40)),
                          ),
                        )
                      : Container(
                          width: 350,
                          height: 500,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                        ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () =>
                        imageClassification(widget.selectedImage!.path),
                    child: Container(
                      height: 55,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Text(
                          'DETECT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                        _results.isNotEmpty ? '$_results' : 'no prediction'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
