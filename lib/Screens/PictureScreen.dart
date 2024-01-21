import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_vision/flutter_vision.dart';

class PictureScreen extends StatefulWidget {
  final Uint8List? image;

  final File? selectedImage;

  const PictureScreen({this.image, this.selectedImage, super.key});

  @override
  State<PictureScreen> createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  late FlutterVision _vision;
  @override
  void initState() {
    super.initState();
    loadModel();
    _vision = FlutterVision();
  }

  late List _results = [];

  Future<void> loadModel() async {
    await _vision.loadYoloModel(
        labels: 'assets/labels.txt',
        modelPath: 'assets/best_float32.tflite',
        modelVersion: "yolov5",
        quantization: false,
        numThreads: 1,
        useGpu: false);
  }

  Future imageClassification(File selectedImage) async {
    print('Welcome, ${selectedImage}');
    Uint8List byte = await selectedImage!.readAsBytes();
    final image = await decodeImageFromList(byte);
    print(image);
    final imageHeight = 640;
    final imageWidth = 640;

    var recognitions = await _vision.yoloOnImage(
        bytesList: byte,
        imageHeight: imageHeight,
        imageWidth: imageWidth,
        iouThreshold: 0,
        confThreshold: 0,
        classThreshold: 0);
    var prediction;
    if (recognitions != null) {
      if (recognitions.isNotEmpty) {
        // Continue with processing predictions
        prediction = recognitions[0];
        print('Prediction: $recognitions');
        setState(() {
          _results = [prediction['label'], prediction['confidence']];
        });
      } else {
        setState(() {
          _results = ['No prediction'];
        });
      }
    } else {
      print('Prediction: $recognitions');

      // Handle the case where recognitions is null
      setState(() {
        _results = ['Error: Recognitions is null'];
      });
    }
    print(_results);
    print("abc$recognitions");
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
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 52, 170, 162),
                Color.fromARGB(255, 14, 11, 16),
              ]),
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
                        )),
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
                                  image: FileImage(widget.selectedImage!)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(40))),
                        )
                      : Container(
                          width: 350,
                          height: 500,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                        ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () => {imageClassification(widget.selectedImage!)},
                    child: Container(
                      height: 55,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white),
                      child: const Center(
                        child: Text(
                          'DETECT',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(_results.isNotEmpty ? '$_results' : 'Nothing'),
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
