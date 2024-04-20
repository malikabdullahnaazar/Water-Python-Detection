// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'dart:convert';

class BacteriaDetailsPage extends StatelessWidget {
  final String scientificName;
  final Uint8List? image;

  const BacteriaDetailsPage(
      {super.key, required this.scientificName, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(scientificName),
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
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return jsonData[scientificName];
  }

  Widget _buildBacteriaDetails(Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 350,
            height: 500,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(image!),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(40)),
            ),
          ),
          Text(
            'Scientific Name: $scientificName',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            'Common Name: ${data['common_name']}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            'Description: ${data['description']}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          _buildClassification(data['classification']),
          const SizedBox(height: 10),
          Text(
            'Habitat: ${data['habitat']}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            'Pathogenicity: ${data['pathogenicity']}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            'Health Effects: ${data['health_effects']}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            'Mode of Transmission: ${data['mode_of_transmission']}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            'Incubation Period: ${data['incubation_period']}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          _buildDiseasesCaused(data['diseases_caused']),
          const SizedBox(height: 10),
          Text(
            'Prevalence: ${data['prevalence']}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          _buildDetectionMethods(data['detection_methods']),
          const SizedBox(height: 10),
          _buildTreatmentOptions(data['treatment_options']),
          const SizedBox(height: 10),
          _buildPreventionStrategies(data['prevention_strategies']),
          const SizedBox(height: 10),
          Text(
            'Regulatory Standards: ${data['regulatory_standards']}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          _buildReferences(data['references']),
          const SizedBox(height: 10),
          _buildImages(data['images']),
          const SizedBox(height: 10),
          _buildVirulenceFactors(data['virulence_factors']),
          const SizedBox(height: 10),
          Text(
            'Environmental Impact: ${data['environmental_impact']}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            'Economic Impact: ${data['economic_impact']}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            'Survival and Resistance: ${data['survival_and_resistance']}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildClassification(Map<String, dynamic> classification) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kingdom: ${classification['kingdom']}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Phylum: ${classification['phylum']}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Class: ${classification['class']}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Order: ${classification['order']}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Family: ${classification['family']}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Genus: ${classification['genus']}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Species: ${classification['species']}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildDiseasesCaused(List<String> diseasesCaused) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Diseases Caused:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ...diseasesCaused.map((disease) => Text(disease)),
      ],
    );
  }

  Widget _buildDetectionMethods(List<String> detectionMethods) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Detection Methods:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ...detectionMethods.map((method) => Text(method)),
      ],
    );
  }

  Widget _buildTreatmentOptions(List<String> treatmentOptions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Treatment Options:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ...treatmentOptions.map((option) => Text(option)),
      ],
    );
  }

  Widget _buildPreventionStrategies(List<String> preventionStrategies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Prevention Strategies:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ...preventionStrategies.map((strategy) => Text(strategy)),
      ],
    );
  }

  Widget _buildReferences(List<String> references) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'References:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ...references.map((reference) => Text(reference)),
      ],
    );
  }

  Widget _buildImages(List<String> images) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Images:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ...images.map((image) => Image.network(image)),
      ],
    );
  }

  Widget _buildVirulenceFactors(List<String> virulenceFactors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Virulence Factors:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ...virulenceFactors.map((factor) => Text(factor)),
      ],
    );
  }
}
