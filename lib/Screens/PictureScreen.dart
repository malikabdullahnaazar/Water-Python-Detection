import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';
import 'dart:typed_data';

class PictureScreen extends StatefulWidget {
  final Uint8List? image;
  final File? selectedImage;

  const PictureScreen({this.image, this.selectedImage, super.key});

  @override
  State<PictureScreen> createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  @override
  void initState() {
 
    super.initState();
    loadModel();
  }

  late List _results = [];

  Future loadModel() async {
    String? res = await Tflite.loadModel(
      model: "assets/best_float32.tflite",
      labels: "assets/metadata.txt",
      // useGpuDelegate: true,
    );
    print("Model loading status,$res");
  }

  Future imageClassification(File selectedImage) async {
    print('Welcome, ${selectedImage}');
    var recognitions = await Tflite.detectObjectOnImage(
        path: selectedImage.path,
        model: "YOLO",
        threshold: 0.3,
        imageMean: 0.0,
        imageStd: 255.0,
        numResultsPerClass: 1);

    if (recognitions != null) {
      if (recognitions.isNotEmpty) {
        // Continue with processing predictions
        var prediction = recognitions[0];
        print('Prediction: $prediction');
        setState(() {
          _results = [prediction['label'], prediction['confidence']];
        });
      } else {
        setState(() {
          _results = ['No prediction'];
        });
      }
    } else {
      // Handle the case where recognitions is null
      setState(() {
        _results = ['Error: Recognitions is null'];
      });
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
              gradient: LinearGradient(colors: [
                Color(0xffB81736),
                Color(0xff281537),
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
