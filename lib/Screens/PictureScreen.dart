// ignore_for_file: unnecessary_import, depend_on_referenced_packages, file_names

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:water_pathogen_detection_system/commonUtils/Constancts.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:flutter/services.dart';

class PictureScreen extends StatefulWidget {
  final Uint8List? image;
  final File? selectedImage;
  const PictureScreen({super.key, this.image, this.selectedImage});

  @override
  State<PictureScreen> createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  final List<dynamic> _results = [];

  final String _labelsFileName = 'assets/labels.txt';
  late List<String> labels;
  late Interpreter _interpreter;
  @override
  void initState() {
    super.initState();
    loadModel().then((_) {
      if (kDebugMode) {
        print("Model loaded successfully");
      }
    }).catchError((error) {
      if (kDebugMode) {
        print("Error loading model: $error");
      }
    });
  }

  Future<void> loadLabels() async {
    labels = await FileUtil.loadLabels(_labelsFileName);
    if (labels.isNotEmpty) {
      if (kDebugMode) {
        print('Labels loaded successfully');
      }
    } else {
      if (kDebugMode) {
        print('Unable to load labels');
      }
    }
  }

  List<List<List<num>>> _preProcess(img.Image image) {
    final imgResized = img.copyResize(image, width: 640, height: 480);

    return convertImageToMatrix(imgResized);
  }

  List<List<List<num>>> convertImageToMatrix(img.Image image) {
    return List.generate(
      image.height,
      (y) => List.generate(
        image.width,
        (x) {
          final pixel = image.getPixel(x, y);
          // Extract RGB components from the pixel
          final int r = img.getRed(pixel);
          final int g = img.getGreen(pixel);
          final int b = img.getBlue(pixel);
          // Normalize the RGB components to the range [0, 1]
          return [r / 255.0, g / 255.0, b / 255.0];
        },
      ),
    );
  }

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('best_float32.tflite');
  }

  Future<void> imageClassification(String imagepath) async {
    try {
      if (kDebugMode) {
        print("Started image classification...");
      }
      img.Image? image = await _loadImage(imagepath);
      final input = _preProcess(image!);
      // Correctly set up the output buffer to match the model's expected output shape
      final outputBuffer =
          TensorBuffer.createFixedSize([1, 73, 2100], TfLiteType.float32);
      _interpreter.run([input], outputBuffer);
      var outputsList = outputBuffer.getDoubleList();
      print(outputBuffer);
      // for (int i = 0; i < outputsList.length; i += 6) {
      //   // Each prediction is assumed to consist of 6 elements
      //   final score = outputsList[
      //       i + 4]; // The score is assumed to be at the 5th position
      //   if (score > 0.5) {
      //     // Applying a threshold to filter predictions
      //     final labelIndex = outputsList[i + 5]
      //         .toInt(); // The label index is assumed to be at the 6th position
      //     final label = labels[labelIndex];
      //     if (kDebugMode) {
      //       print("prediction: label $label");
      //     }
      //   }
      // }
    } catch (error) {
      if (kDebugMode) {
        print('Error during image classification: $error');
      }
    }
  }

  Future<img.Image?> _loadImage(String imagePath) async {
    final File imageFile = File(imagePath);
    if (!await imageFile.exists()) {
      if (kDebugMode) {
        print('File does not exist: $imagePath');
      }
      return null;
    }
    final Uint8List imageData = await imageFile.readAsBytes();
    return img.decodeImage(imageData);
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
                  Text(_results.isNotEmpty ? '$_results' : 'no prediction')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
