import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:water_pathogen_detection_system/Model/Classifier.dart';

class ClassifierFloat extends Classifier {
  ClassifierFloat({int? numThreads}) : super(numThreads: numThreads);

  @override
  String get modelName => 'yolov8n.tflite';

  @override
  NormalizeOp get preProcessNormalizeOp => NormalizeOp(127.5, 127.5);

  @override
  NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 1);
}
