// ignore_for_file: file_names, must_be_immutable, use_build_context_synchronously

import 'dart:convert' show LineSplitter, json;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Pathogen/FirebaseServices/FireStore.dart';
import 'package:Pathogen/Screens/BacteriaDetailPage.dart';
import 'package:Pathogen/Screens/HomeScreen2.dart';
import 'package:Pathogen/commonUtils/SnakBar.dart';

class ResultPage extends StatelessWidget {
  final List results;
  Uint8List selectedimage;
  final FirestoreMethods _firestore = FirestoreMethods();
  ResultPage({super.key, required this.results, required this.selectedimage}) {
    _loadLabels();
  }

  List<String> labels = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detection Results'),
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BacteriaDetailsPage(
                          scientificName: results[index]['tag'],
                          image: selectedimage)));
            },
            child: Card(
              child: ListTile(
                leading:
                    Image.memory(selectedimage), //Image.file(selectedimage),
                title: Text('${results[index]['tag']}'),
                subtitle: Text(
                    'Confidence: ${results[index]['box'][4].toStringAsFixed(2)}%'),
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: double.parse(
                                results[index]['box'][4].toStringAsFixed(2)) >
                            0.5
                        ? Colors.green
                        : Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    results[index]['box'][4].toStringAsFixed(2),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                for (var result in results) {
                  var res = await _getprediction(result['tag']);
                  print('res$res');
                }

                //

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Dialog(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(width: 20),
                            Text("Saving Results..."),
                          ],
                        ),
                      ),
                    );
                  },
                );
                late String res;
                // Save results
                for (var result in results) {
                  res = await _firestore.storePrediction(
                    result['tag'],
                    double.parse(result['box'][4].toStringAsFixed(2)),
                    selectedimage,
                    _getprediction(result['tag']),
                  );
                }
                Navigator.pop(context); // Close the progress dialog
                ShowSnackBar(res, context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen2()));
              },
              child: const Text('Save Results'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen2()));
              },
              child: const Text('Detect Next'),
            ),
          ],
        ),
      ),
    );
  }

  _loadLabels() async {
    String data = await rootBundle.loadString('assets/labels.txt');
    labels = const LineSplitter().convert(data);
  }

  Future<bool> _getprediction(result) async {
    String jsonString =
        await rootBundle.loadString('assets/bacteria_data.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    Map<String, dynamic>? matchingBacteria = jsonData['items'].firstWhere(
      (entry) => entry['scientific_name'] == result,
      orElse: () => null,
    );
    return matchingBacteria?['pathogenicity'];
  }
}
