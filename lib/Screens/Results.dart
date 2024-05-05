// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Pathogen/FirebaseServices/FireStore.dart';
import 'package:Pathogen/Screens/BacteriaDetailPage.dart';
import 'package:Pathogen/Screens/Blogs/Blogs.dart';
import 'package:Pathogen/Screens/HomeScreen2.dart';
import 'package:Pathogen/Screens/ProfileScreen.dart';
import 'package:Pathogen/commonUtils/Constancts.dart';
import 'package:Pathogen/commonUtils/SnakBar.dart';

class MySavedResultsPage extends StatefulWidget {
  const MySavedResultsPage({super.key});

  @override
  _MySavedResultsPageState createState() => _MySavedResultsPageState();
}

class _MySavedResultsPageState extends State<MySavedResultsPage>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final TabController _tabController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirestoreMethods _firestoremethod = FirestoreMethods();
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> _getPredictions(
      {bool? isSafe}) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection("Predictions")
        .where('userId', isEqualTo: _auth.currentUser!.uid);

    if (_searchTerm.isNotEmpty) {
      String searchLowercase = _searchTerm.toLowerCase();
      query = query
          .where('label', isGreaterThanOrEqualTo: searchLowercase)
          .where('label', isLessThan: searchLowercase.toUpperCase());
    }

    if (_selectedDate != null) {
      query = query.where('predictionDate', isEqualTo: _selectedDate);
    }

    if (isSafe != null) {
      query = query.where('prediction', isEqualTo: isSafe);
    }
    query = query.orderBy('predictionDate', descending: true);

    return query.get();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().toLocal(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().toLocal(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          _selectedDate =
              DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
          if (kDebugMode) {
            print(_selectedDate);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Results'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: _showDatePicker,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Predictions',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchTerm = '';
                    });
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchTerm = value;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: _getPredictions(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Image.asset(
                        'assets/images/nodata.png',
                      ), // Replace with your asset's path
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: () async {
                        setState(() {
                          _selectedDate = null;
                          // Reset any other filters as needed
                        });
                        await _getPredictions(); // Refetch the data
                      },
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot document =
                              snapshot.data!.docs[index];
                          bool isSafe = document['prediction']
                              as bool; // Assuming 'prediction' is a bool
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BacteriaDetailsPage(
                                            scientificName: document['label'],
                                            imgurl: document['photoUrl'],
                                          )));
                            },
                            child: Card(
                              margin: const EdgeInsets.all(8.0),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ListTile(
                                hoverColor: Colors.blue[50],
                                leading: Image.network(
                                  document['photoUrl'],
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  document['label'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Confidence: ${document['confidence']}'),
                                    Text(
                                        'Date: ${document['predictionDate'].toDate().toLocal().toString().substring(0, 10)}'),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 0),
                                      decoration: BoxDecoration(
                                        color:
                                            isSafe ? Colors.green : Colors.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        isSafe ? 'Safe' : 'Danger',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        _showDeleteDialog(
                                            context, document['predictionId']);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        unselectedFontSize: 16,
        selectedFontSize: 16,
        currentIndex: 0,
        selectedItemColor: primaryColor,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined), label: 'Blogs'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen2()));
              break;
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Blogs()));
              break;
            case 2:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfleScreen()));
              break;
          }
        },
      ),
    );
  }

  _showDeleteDialog(BuildContext context, result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Prediction'),
          content:
              const Text('Are you sure you want to delete this prediction?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                bool res = await _firestoremethod.deletePrediction(result);
                if (res) {
                  ShowSnackBar("Prediction deleted successfully!", context);
                  _getPredictions();
                }
                _getPredictions();

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
