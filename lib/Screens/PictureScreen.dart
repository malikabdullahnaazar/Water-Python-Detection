import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_vision/flutter_vision.dart';

class PictureScreen extends StatefulWidget {
  @override
  _PictureScreenState createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  late FlutterVision _vision;
  List<dynamic> _results = [];
  File? _image;

  @override
  void initState() {
    super.initState();
    _vision = FlutterVision();
    final rs = loadModel().then((_) {
      print("Model loaded successfully ");
    }).catchError((error) {
      print("Error loading model: $error");
    });
    print("ls${rs}");
  }

  Future<void> loadModel() async {
    final res = await _vision.loadYoloModel(
        labels: 'assets/labels8n.txt',
        modelPath: 'assets/yolov8n.tflite',
        modelVersion: "yolov8",
        quantization: false,
        numThreads: 2,
        useGpu: false);
    return res;
  }

  Future<void> imageClassification(File image) async {
    Uint8List imageBytes = await image.readAsBytes();
    final images = await decodeImageFromList(imageBytes);
    var recognitions = await _vision.yoloOnImage(
        bytesList: imageBytes,
        imageHeight: images.height, // Replace with actual image height
        imageWidth: images.width, // Replace with actual image width
        iouThreshold: 0.8,
        confThreshold: 0.4,
        classThreshold: 0.5);
    print("recognitions${recognitions}");

    setState(() {
      _results = recognitions;
    });
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() {
        _image = File(photo.path);
      });
      imageClassification(File(photo.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YOLOv8 Image Classification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!, height: 300),
            SizedBox(height: 20),
            _results.isEmpty
                ? Text('No results')
                : Expanded(
                    child: ListView.builder(
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_results[index]['label']),
                          subtitle: Text(
                              'Confidence: ${_results[index]['confidence'].toStringAsFixed(2)}'),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
