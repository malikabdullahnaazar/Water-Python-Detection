import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? selectedImage;
  Uint8List? image;
  late List _results = [];
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    String? res = await Tflite.loadModel(
      model: "assets/best_float32.tflite",
      labels: "assets/metadata.txt",
      // useGpuDelegate: true,
    );
    print("Model loading status,$res");
  }

 Future imageClassification(File selectedImage) async {
  print('Welcome, ${selectedImage.path}');
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
      backgroundColor: Colors.purpleAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image != null
              ? Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height / 2,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: MemoryImage(image!)),
                  ),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          pickImageFromCamera();
                        },
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          size: 50,
                        ),
                      ),
                      Text('Camera')
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          pickImage();
                        },
                        icon: const Icon(Icons.image, size: 50),
                      ),
                      Text('Gallery')
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          imageClassification(selectedImage!);
                        },
                        icon: const Icon(Icons.image, size: 50),
                      ),
                      Text(_results.isNotEmpty ? '$_results' : 'Nothing'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future pickImage() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage != null) {
      setState(() {
        selectedImage = File(returnImage.path);
        image = selectedImage!.readAsBytesSync();
      });
    } else
      return;
  }

  Future pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage != null) {
      setState(() {
        selectedImage = File(returnImage.path);
        image = selectedImage!.readAsBytesSync();
      });
    } else
      return;
  }
}
