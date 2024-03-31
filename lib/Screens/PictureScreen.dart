import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:water_pathogen_detection_system/commonUtils/Constancts.dart';
import 'package:water_pathogen_detection_system/commonUtils/Utils.dart';

class PictureScreen extends StatefulWidget {
  final Uint8List? image;
  final File? selectedImage;

  const PictureScreen({this.image, this.selectedImage, super.key});

  @override
  State<PictureScreen> createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  FlutterVision vision = FlutterVision();
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  late List _results = [];

  Future loadModel() async {
    // final model = LocalYoloModel(
    //     id: id,
    //     task: Task.detect /* or Task.classify */,
    //     format: Format.tflite /* or Format.coreml*/,
    //     modelPath: modelPath,
    //     metadataPath: metadataPath,
    //   );
//     final objectDetector = ObjectDetector(model: model);
// await objectDetector.loadModel();
    await vision.loadYoloModel(
        labels: "assets/metadata.txt",
        modelPath: "assets/best_float32.tflite",
        modelVersion: "yolov8",
        quantization: false,
        numThreads: 1,
        useGpu: false);
  }

  Future imageClassification(image) async {
    print('Welcome, ${image}');
    try {
      // objectDetector.detect(imagePath: imagePath)
      var recognitions = await vision.yoloOnImage(
        bytesList: image,
        imageHeight: image.height,
        imageWidth: image.width,
        iouThreshold: 0.8,
        confThreshold: 0.4,
        classThreshold: 0.7,
      );

      if (recognitions != null) {
        if (recognitions.isNotEmpty) {
          // Continue with processing predictions
          var prediction = recognitions[0];
          print('Prediction: $prediction');
          setState(() {
            _results = [prediction['label'], prediction['confidence']];
          });

          // Show a Snackbar with the prediction results
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Prediction: ${prediction['label']}'),
            ),
          );
        } else {
          setState(() {
            _results = ['No prediction'];
          });

          // Show a Snackbar indicating no prediction
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No prediction'),
            ),
          );
        }
      } else {
        // Handle the case where recognitions is null
        setState(() {
          _results = ['Error: Recognitions is null'];
        });

        // Show a Snackbar for the error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: Recognitions is null'),
          ),
        );
      }
    } catch (error) {
      // Handle any unexpected errors
      print('Error: $error');

      // Show a Snackbar for the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
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
                    onTap: () => {imageClassification(widget.image!)},
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
                    child: Text(_results.isNotEmpty ? '$_results' : ''),
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
