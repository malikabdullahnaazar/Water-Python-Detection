import 'dart:math';
import 'package:flutter/material.dart';
import 'package:water_pathogen_detection_system/commonUtils/Constancts.dart';

void main() {
  runApp(MyApp());
}

class Blog {
  final String title;
  final String content;

  Blog({required this.title, required this.content});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlogScreen(),
    );
  }
}

class BlogScreen extends StatelessWidget {
  final List<Blog> blogs = [
    Blog(
      title: "Ensuring Clean Water: A Vital Step Towards Public Health",
      content:
          "In today's blog, we explore the importance of water safety measures and cutting-edge pathogen detection technologies. Join us as we delve into the critical role these advancements play in securing public health and well-being.",
    ),
    Blog(
      title: "The Impact of Waterborne Pathogens on Communities",
      content:
          "Discover the real-life consequences of waterborne pathogens and the communities affected by them. We shed light on the challenges they face and how innovative detection systems are making strides to mitigate risks and enhance water safety.",
    ),
    Blog(
      title:
          "Advancements in Water Pathogen Detection: A Technological Breakthrough",
      content:
          "Stay updated on the latest breakthroughs in water pathogen detection technology. From rapid testing methods to smart sensors, we explore how these innovations are revolutionizing the way we monitor and ensure the safety of our water sources.",
    ),
    Blog(
      title: "Water Safety Tips: A Guide for Every Household",
      content:
          "Our experts share essential tips for maintaining water safety at home. Learn about simple yet effective practices that can safeguard your family from waterborne diseases. A must-read for every household!",
    ),
    Blog(
      title:
          "The Role of IoT in Water Safety: Smart Solutions for a Safer Future",
      content:
          "Uncover the potential of Internet of Things (IoT) in revolutionizing water safety. Explore how smart devices and real-time data analytics are being utilized to create a proactive approach to pathogen detection and water quality management.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Water Safety Blogs'),
          centerTitle: true,
          backgroundColor: Colors.blue,
          flexibleSpace: Container(
              decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, secondaryColor],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ))),
      body: ListView.builder(
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Handle blog item click, navigate to full content, etc.
              print("Clicked on blog ${index + 1}");
            },
            child: Card(
              margin: EdgeInsets.all(8.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blogs[index].title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      blogs[index].content,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
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
}
