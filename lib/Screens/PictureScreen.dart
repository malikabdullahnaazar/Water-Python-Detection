import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:water_pathogen_detection_system/commonUtils/Constancts.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
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
  List<dynamic> _results = [];
  late Interpreter _interpreter;
  @override
  void initState() {
    super.initState();
    loadModel().then((_) {
      print("Model loaded successfully");
    }).catchError((error) {
      print("Error loading model: $error");
    });
  }

  List<List<List<num>>> _preProcess(img.Image image) {
    final imgResized = img.copyResize(image, width: 320, height: 320);

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
    _interpreter = await Interpreter.fromAsset('yolov8n_int8.tflite');
  }

  Future<void> imageClassification(String imagepath) async {
    try {
      print("Started image classification...");
      img.Image? image = await _loadImage('assets/1790.png');
      final input = _preProcess(image!);
      // Correctly set up the output buffer to match the model's expected output shap
      final outputBuffer =
          TensorBuffer.createFixedSize([1, 73, 2100], TfLiteType.float32);
      // final output = List<num>.filled(1 * 84 * 8400, 0).reshape([1, 84, 8400]);

      int predictionTimeStart = DateTime.now().millisecondsSinceEpoch;
      _interpreter.run([input], outputBuffer);
      int predictionTime =
          DateTime.now().millisecondsSinceEpoch - predictionTimeStart;
      print('Prediction time: $predictionTime ms');
      // print('Prediction results: $output');
    } catch (error) {
      print('Error during image classification: $error');
    }
  }

  Future<img.Image?> _loadImage(String imagePath) async {
    final imageData = await rootBundle.load(imagePath);
    return img.decodeImage(imageData.buffer.asUint8List());
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
