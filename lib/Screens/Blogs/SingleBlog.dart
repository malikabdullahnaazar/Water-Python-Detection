// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:water_pathogen_detection_system/commonUtils/Constancts.dart';

class SingleBlog extends StatelessWidget {
  final String? photoUrl;
  final String? title;
  final String? description;

  const SingleBlog({this.photoUrl, this.title, this.description, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            FontAwesomeIcons.arrowLeft,
            size: 24,
            color: primaryColor,
          ),
        ),
        title: Text(
          title ?? "Blog",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(photoUrl ?? ''),
                    fit: BoxFit.fitWidth,
                  ),
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title ?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  description ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
