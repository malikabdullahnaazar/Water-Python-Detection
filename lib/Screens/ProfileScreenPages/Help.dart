import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:water_pathogen_detection/commonUtils/constancts.dart';

class Help extends StatelessWidget {
  Help({super.key});
  final List<Map<String, dynamic>> data = [
    {
      'question':
          'What are some tips for capturing high-quality larvae images?',
      'answer':
          'Ensure optimal image quality by using adequate lighting and focusing on the larvae. For best results, position the larvae against a contrasting background and minimize distractions in the frame.',
    },
    {
      'question': 'How do I interpret the app\'s detection results?',
      'answer':
          'Once the app identifies a larvae species, tap on the result for detailed information. Learn about the characteristics, habitat, and common behaviors of the detected larvae to enhance your understanding.',
    },
    {
      'question': 'Are there any advanced features in the app?',
      'answer':
          'Dive into advanced features such as species comparison, lifecycle tracking, and data export for a more in-depth analysis. Check the settings menu for customization options tailored to your preferences.',
    },
    {
      'question': 'Can I share my findings with other users?',
      'answer':
          'Absolutely! Join our community forums to share your discoveries, insights, and engage in discussions with fellow enthusiasts. Collaborate to expand your knowledge and contribute to the collective learning experience.',
    },
    {
      'question': 'What should I do if I encounter difficulties with the app?',
      'answer':
          'If you experience issues, check our troubleshooting guide in the Help Center. It covers common problems and solutions. If the issue persists, contact our support team for personalized assistance.',
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
            icon: const Icon(FontAwesomeIcons.arrowLeft,
                size: 24, color: Colors.white)),
        title: const Text(
          "Help Center ",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 100,
                decoration: const BoxDecoration(
                    gradient:
                        LinearGradient(colors: [primaryColor, secondaryColor])),
              ),
              for (var item in data)
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 7, top: 2),
                    child: Container(
                        width: MediaQuery.sizeOf(context).width,
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
                        )),
                  ),
                ),
            ],
          )),
    );
  }
}
