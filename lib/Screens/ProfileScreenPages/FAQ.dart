import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:water_pathogen_detection_system/commonUtils/Constancts.dart';

class FAQ extends StatelessWidget {
  FAQ({Key? key});

  final List<Map<String, dynamic>> data = [
    {
      'question': 'What is the Water Pathogen Detection System for?',
      'answer':
          'The system is designed to identify and analyze waterborne pathogens using advanced detection techniques, ensuring water safety for various applications such as drinking water quality assessment and environmental monitoring.',
      'icon': FontAwesomeIcons.water,
    },
    {
      'question': 'How does the Water Pathogen Detection System work?',
      'answer':
          'The system utilizes cutting-edge technologies, including sensors and data analysis algorithms, to detect and analyze pathogens in water samples. It provides accurate and rapid results to facilitate prompt actions in response to water quality issues.',
      'icon': FontAwesomeIcons.microscope,
    },
    {
      'question': 'What types of waterborne pathogens can the system detect?',
      'answer':
          'The system is capable of detecting a wide range of waterborne pathogens, including bacteria, viruses, and other microorganisms. It offers comprehensive coverage for various water sources and environments.',
      'icon': FontAwesomeIcons.virus,
    },
    {
      'question': 'How accurate is the water pathogen detection process?',
      'answer':
          'Accuracy is influenced by factors such as sample quality and system calibration. The system undergoes continuous improvement through updates and user feedback to enhance its detection accuracy and reliability.',
      'icon': FontAwesomeIcons.chartLine,
    },
    {
      'question':
          'Do I need an internet connection to use the Water Pathogen Detection System?',
      'answer':
          'An internet connection is required for initial setup, updates, and accessing the latest pathogen databases. However, basic detection functionalities can be performed offline, ensuring usability in diverse environments.',
      'icon': FontAwesomeIcons.wifi,
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
                height: AppBar().preferredSize.height), // Spacer for AppBar
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Card(
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ExpansionTile(
                        iconColor: Theme.of(context).primaryColor,
                        textColor: Colors.black,
                        collapsedIconColor: Theme.of(context).primaryColor,
                        title: Row(
                          children: [
                            Icon(
                              data[index]['icon'],
                              size: 20,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                data[index]["question"],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              data[index]["answer"],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
