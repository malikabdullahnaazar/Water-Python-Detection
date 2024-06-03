// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'dart:convert';

class BacteriaDetailsPage extends StatelessWidget {
  final String scientificName;
  final Uint8List? image;
  final String? imgurl;

  const BacteriaDetailsPage(
      {super.key, required this.scientificName, this.image, this.imgurl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(scientificName),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: _loadBacteriaData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data = snapshot.data!;
            return _buildBacteriaDetails(data);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>?> _loadBacteriaData() async {
    String jsonString =
        await rootBundle.loadString('assets/bacteria_data.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    Map<String, dynamic>? matchingBacteria = jsonData['items'].firstWhere(
      (entry) => entry['scientific_name'] == scientificName,
      orElse: () => null,
    );
    return matchingBacteria;
  }

  Widget _buildBacteriaDetails(Map<String, dynamic> data) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imgurl != null
                      ? NetworkImage(imgurl!) as ImageProvider
                      : image != null
                          ? MemoryImage(image!) as ImageProvider
                          : const AssetImage(
                                  'assets/images/image_not_found.png')
                              as ImageProvider,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Scientific Name: \n$scientificName',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Common Name:\n ${data['common_name']}',
              style: const TextStyle(fontSize: 20, color: Colors.teal),
            ),
            const SizedBox(height: 20),
            Text(
              'Description:\n ${data['description']}',
              style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 20),
            _buildClassification(data['classification']),
            const SizedBox(height: 20),
            Text(
              'Habitat:\n ${data['habitat']}',
              style: const TextStyle(fontSize: 18, color: Colors.deepOrange),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'Pathogenicity:',
                  style: const TextStyle(fontSize: 18, color: Colors.redAccent),
                ),
                const SizedBox(
                    width: 8), // Add some space between the text and the icon
                data['pathogenicity'] == true
                    ? const Icon(Icons.check_circle,
                        color: Colors.green, size: 24)
                    : const Icon(Icons.cancel, color: Colors.red, size: 24),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Health Effects:\n ${data['health_effects']}',
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            const SizedBox(height: 20),
            Text(
              'Mode of Transmission:\n ${data['mode_of_transmission']}',
              style: const TextStyle(fontSize: 18, color: Colors.blueAccent),
            ),
            const SizedBox(height: 20),
            Text(
              'Incubation Period:\n ${data['incubation_period']}',
              style: const TextStyle(fontSize: 18, color: Colors.purple),
            ),
            const SizedBox(height: 20),
            _buildDiseasesCaused(data['diseases_caused']),
            const SizedBox(height: 20),
            Text(
              'Prevalence:\n ${data['prevalence']}',
              style: const TextStyle(fontSize: 18, color: Colors.brown),
            ),
            const SizedBox(height: 20),
            _buildDetectionMethods(data['detection_methods']),
            const SizedBox(height: 20),
            _buildTreatmentOptions(data['treatment_options']),
            const SizedBox(height: 20),
            _buildPreventionStrategies(data['prevention_strategies']),
            const SizedBox(height: 20),
            Text(
              'Regulatory Standards:\n ${data['regulatory_standards']}',
              style: const TextStyle(fontSize: 18, color: Colors.indigo),
            ),
            const SizedBox(height: 20),
            _buildReferences(data['references']),
            const SizedBox(height: 20),
            _buildImages(data['images']),
            const SizedBox(height: 20),
            _buildVirulenceFactors(data['virulence_factors']),
            const SizedBox(height: 20),
            Text(
              'Environmental Impact:\n ${data['environmental_impact']}',
              style: const TextStyle(fontSize: 18, color: Colors.orange),
            ),
            const SizedBox(height: 20),
            Text(
              'Economic Impact:\n ${data['economic_impact']}',
              style: const TextStyle(fontSize: 18, color: Colors.amber),
            ),
            const SizedBox(height: 20),
            Text(
              'Survival and Resistance:\n ${data['survival_and_resistance']}',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassification(Map<String, dynamic> classification) {
    return ExpansionTile(
      title: const Text('Classification',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal)),
      children: [
        Text('Kingdom: ${classification['kingdom']}',
            style: const TextStyle(fontSize: 18)),
        Text('Phylum: ${classification['phylum']}',
            style: const TextStyle(fontSize: 18)),
        Text('Class: ${classification['class']}',
            style: const TextStyle(fontSize: 18)),
        Text('Order: ${classification['order']}',
            style: const TextStyle(fontSize: 18)),
        Text('Family: ${classification['family']}',
            style: const TextStyle(fontSize: 18)),
        Text('Genus: ${classification['genus']}',
            style: const TextStyle(fontSize: 18)),
        Text('Species: ${classification['species']}',
            style: const TextStyle(fontSize: 18)),
      ],
    );
  }

  Widget _buildDiseasesCaused(dynamic diseasesCaused) {
    if (diseasesCaused is! List<dynamic> || diseasesCaused.isEmpty) {
      return const Text('No diseases caused or error in data format');
    }
    return ExpansionTile(
      title: const Text('Diseases Caused',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
      children: diseasesCaused
          .map<Widget>(
              (disease) => Text(disease, style: const TextStyle(fontSize: 18)))
          .toList(),
    );
  }

  Widget _buildDetectionMethods(dynamic detectionMethods) {
    if (detectionMethods is! List<dynamic> || detectionMethods.isEmpty) {
      return const Text('No detection methods available');
    }
    return ExpansionTile(
      title: const Text('Detection Methods',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
      children: detectionMethods
          .map<Widget>(
              (method) => Text(method, style: const TextStyle(fontSize: 18)))
          .toList(),
    );
  }

  Widget _buildTreatmentOptions(dynamic treatmentOptions) {
    if (treatmentOptions is! List<dynamic> || treatmentOptions.isEmpty) {
      return const Text('No treatment options available');
    }
    return ExpansionTile(
      title: const Text('Treatment Options',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
      children: treatmentOptions
          .map<Widget>(
              (option) => Text(option, style: const TextStyle(fontSize: 18)))
          .toList(),
    );
  }

  Widget _buildPreventionStrategies(dynamic preventionStrategies) {
    if (preventionStrategies is! List<dynamic> ||
        preventionStrategies.isEmpty) {
      return const Text('No prevention strategies available');
    }
    return ExpansionTile(
      title: const Text('Prevention Strategies',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple)),
      children: preventionStrategies
          .map<Widget>((strategy) =>
              Text(strategy, style: const TextStyle(fontSize: 18)))
          .toList(),
    );
  }

  Widget _buildReferences(dynamic references) {
    if (references is! List<dynamic> || references.isEmpty) {
      return const Text('No references available');
    }
    return ExpansionTile(
      title: const Text('References',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown)),
      children: references
          .map<Widget>((reference) => InkWell(
                child: Text(reference, style: const TextStyle(fontSize: 18)),
                // onTap: () => launch(reference),
              ))
          .toList(),
    );
  }

  Widget _buildImages(dynamic images) {
    print('images $images, type: ${images.runtimeType}');
    if (images is! List<dynamic> || images.isEmpty) {
      return const Text('No images available');
    }
    return ExpansionTile(
      title: const Text('Images',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange)),
      children: images
          .map<Widget>((image) =>
              Image.network(image, errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/image_not_found.png',
                  height: 200,
                );
              }))
          .toList(),
    );
  }

  Widget _buildVirulenceFactors(dynamic virulenceFactors) {
    if (virulenceFactors is! List<dynamic> || virulenceFactors.isEmpty) {
      return const Text('No virulence factors available');
    }
    return ExpansionTile(
      title: const Text('Virulence Factors',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber)),
      children: virulenceFactors
          .map<Widget>(
              (factor) => Text(factor, style: const TextStyle(fontSize: 18)))
          .toList(),
    );
  }
}
