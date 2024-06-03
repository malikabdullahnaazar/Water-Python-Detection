import 'dart:convert' show LineSplitter, json;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Pathogen/FirebaseServices/FireStore.dart';
import 'package:Pathogen/Screens/BacteriaDetailPage.dart';
import 'package:Pathogen/Screens/HomeScreen2.dart';
import 'package:Pathogen/commonUtils/SnakBar.dart';

class ResultPage extends StatefulWidget {
  final List results;
  final Uint8List selectedimage;
  ResultPage({super.key, required this.results, required this.selectedimage});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final FirestoreMethods _firestore = FirestoreMethods();
  List<String> labels = [];
  List<bool> predictionResults = [];

  @override
  void initState() {
    super.initState();
    _loadLabels();
    _getPredictions();
  }

  Future<void> _loadLabels() async {
    String data = await rootBundle.loadString('assets/labels.txt');
    setState(() {
      labels = const LineSplitter().convert(data);
    });
  }

  Future<void> _getPredictions() async {
    List<bool> results = [];
    for (var result in widget.results) {
      bool prediction = await _getprediction(result['tag']);
      results.add(prediction);
    }
    setState(() {
      predictionResults = results;
    });
  }

  Future<bool> _getprediction(result) async {
    String jsonString =
        await rootBundle.loadString('assets/bacteria_data.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    Map<String, dynamic>? matchingBacteria = jsonData['items'].firstWhere(
      (entry) => entry['scientific_name'] == result,
      orElse: () => null,
    );
    return matchingBacteria?['pathogenicity'] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detection Results'),
      ),
      body: predictionResults.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: widget.results.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BacteriaDetailsPage(
                                scientificName: widget.results[index]['tag'],
                                image: widget.selectedimage)));
                  },
                  child: Card(
                    child: ListTile(
                      leading: Image.memory(widget.selectedimage),
                      title: Text('${widget.results[index]['tag']}'),
                      subtitle: Text(
                          'Confidence: ${widget.results[index]['box'][4].toStringAsFixed(2)}%'),
                      trailing: Column(children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: double.parse(widget.results[index]['box'][4]
                                        .toStringAsFixed(2)) >
                                    0.5
                                ? Colors.green
                                : Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            widget.results[index]['box'][4].toStringAsFixed(2),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                          decoration: BoxDecoration(
                            color: predictionResults[index]
                                ? Colors.green
                                : Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            predictionResults[index] ? 'Safe' : 'Danger',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ]),
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
                for (var result in widget.results) {
                  var res = await _getprediction(result['tag']);
                  print('res$res');
                }

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
                for (var result in widget.results) {
                  res = await _firestore.storePrediction(
                    result['tag'],
                    double.parse(result['box'][4].toStringAsFixed(2)),
                    widget.selectedimage,
                    (await _getprediction(result['tag'])) as Future<bool>,
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
}
