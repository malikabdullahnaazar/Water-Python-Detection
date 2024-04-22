// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Pathogen/commonUtils/Constancts.dart';

class SettingsPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const SettingsPage({Key? key});

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
          "Settings",
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 80), // Spacer for AppBar
              CardSection(
                title: "Notification Settings",
                icon: FontAwesomeIcons.bell,
                details: [
                  {"label": "Receive Notifications", "value": "Enabled"},
                  {"label": "Notification Sound", "value": "Default"},
                ],
              ),
              SizedBox(
                height: 16,
              ),
              CardSection(
                title: "Appearance",
                // ignore: deprecated_member_use
                icon: FontAwesomeIcons.paintBrush,
                details: [
                  {"label": "Theme", "value": "Dark Mode"},
                  {"label": "Font Size", "value": "Medium"},
                ],
              ),
              SizedBox(
                height: 16,
              ),
              // Add more sections as needed
            ],
          ),
        ),
      ),
    );
  }
}

class CardSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Map<String, String>> details;

  const CardSection({
    super.key,
    required this.title,
    required this.icon,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              for (var detail in details)
                Row(
                  children: [
                    CircleAvatar(
                      child: Icon(
                        icon,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          detail["label"]!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          detail["value"]!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
