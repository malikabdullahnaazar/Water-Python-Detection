import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:water_pathogen_detection/commonUtils/constancts.dart';

class FAQ extends StatelessWidget {
  FAQ({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> data = [
    {
      'question': 'What is the Water Pathogen Detection System for?',
      'answer':
          'The system is designed to identify and analyze waterborne pathogens using advanced detection techniques, ensuring water safety for various applications such as drinking water quality assessment and environmental monitoring.',
    },
    {
      'question': 'How does the Water Pathogen Detection System work?',
      'answer':
          'The system utilizes cutting-edge technologies, including sensors and data analysis algorithms, to detect and analyze pathogens in water samples. It provides accurate and rapid results to facilitate prompt actions in response to water quality issues.',
    },
    {
      'question': 'What types of waterborne pathogens can the system detect?',
      'answer':
          'The system is capable of detecting a wide range of waterborne pathogens, including bacteria, viruses, and other microorganisms. It offers comprehensive coverage for various water sources and environments.',
    },
    {
      'question': 'How accurate is the water pathogen detection process?',
      'answer':
          'Accuracy is influenced by factors such as sample quality and system calibration. The system undergoes continuous improvement through updates and user feedback to enhance its detection accuracy and reliability.',
    },
    {
      'question':
          'Do I need an internet connection to use the Water Pathogen Detection System?',
      'answer':
          'An internet connection is required for initial setup, updates, and accessing the latest pathogen databases. However, basic detection functionalities can be performed offline, ensuring usability in diverse environments.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            FontAwesomeIcons.arrowLeft,
            size: 24,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Interactive FAQ's",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: const BoxDecoration(
                gradient:
                    LinearGradient(colors: [primaryColor, secondaryColor]),
              ),
            ),
            for (var item in data)
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 7, top: 2),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item["question"],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item["answer"],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
