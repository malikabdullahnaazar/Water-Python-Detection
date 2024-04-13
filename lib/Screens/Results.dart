// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

class SavedResult {
  final String imagePath;
  final String predictedText;
  final List<String> suggestions;
  final DateTime date;

  SavedResult({
    required this.imagePath,
    required this.predictedText,
    required this.suggestions,
    required this.date,
  });
}

class MySavedResultsPage extends StatefulWidget {
  const MySavedResultsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MySavedResultsPageState createState() => _MySavedResultsPageState();
}

class _MySavedResultsPageState extends State<MySavedResultsPage> {
  late List<SavedResult> savedResults;
  late List<SavedResult>
      filteredResultsList; // New list to hold filtered results

  DateTime selectedDate = DateTime.now();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    savedResults = generateFakeData(100);
    filteredResultsList =
        savedResults; // Initialize filteredResultsList with all results
  }

  List<SavedResult> filteredResults() {
    return filteredResultsList
        .where((result) =>
            result.date.isAfter(selectedDate) &&
            (searchController.text.isEmpty ||
                result.predictedText
                    .toLowerCase()
                    .contains(searchController.text.toLowerCase())))
        .toList();
  }

  void showRandomResults() {
    setState(() {
      searchController.clear();
      selectedDate = DateTime.now();
      filteredResultsList = generateFakeData(100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Saved Results (${filteredResults().length})'), // Show the count in the title
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text('Filter by Date:'),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );

                    if (pickedDate != null && pickedDate != selectedDate) {
                      setState(() {
                        selectedDate = pickedDate;
                        filteredResultsList =
                            filteredResults(); // Update filteredResultsList on date change
                      });
                    }
                  },
                  child: const Text('Select Date'),
                ),
                const SizedBox(width: 10),
                SingleChildScrollView(
                  child: ElevatedButton(
                    onPressed: () {
                      showRandomResults();
                    },
                    child: const Text('Random'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  filteredResultsList =
                      filteredResults(); // Update filteredResultsList on search change
                });
              },
              decoration: InputDecoration(
                labelText: 'Search by Text',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      searchController.clear();
                      filteredResultsList =
                          filteredResults(); // Update filteredResultsList on clear
                    });
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredResults().length,
              itemBuilder: (context, index) {
                SavedResult result = filteredResults()[index];

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.asset(
                      result.imagePath,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(result.predictedText),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Suggestions:'),
                        for (String suggestion in result.suggestions)
                          Text('- $suggestion'),
                        Text('Date: ${result.date.toLocal()}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Generate fake data based on the given count.
  List<SavedResult> generateFakeData(int count) {
    List<SavedResult> fakeData = [];

    for (int i = 0; i < count; i++) {
      fakeData.add(
        SavedResult(
          imagePath: 'assets/images/logo-removebg-preview.png',
          predictedText:
              faker.lorem.words(3).join(' '), // Generate a random sentence
          suggestions: generateRandomSuggestions(),
          date: DateTime.now()
              .subtract(Duration(days: faker.randomGenerator.integer(30))),
        ),
      );
    }

    return fakeData;
  }

  // Generate random suggestions and return them as a list of strings.
  List<String> generateRandomSuggestions() {
    List<String> suggestions = [];

    int suggestionCount = faker.randomGenerator.integer(5) + 10;

    for (int i = 0; i < suggestionCount; i++) {
      suggestions.add(faker.lorem
          .words(2)
          .join(' ')); // Generate a random two-word suggestion
    }

    return suggestions;
  }
}
