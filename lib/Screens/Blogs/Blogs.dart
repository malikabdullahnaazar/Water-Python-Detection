// ignore_for_file: file_names, non_constant_identifier_names, dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:water_pathogen_detection_system/Screens/Blogs/AddBlogs.dart';
import 'package:water_pathogen_detection_system/Screens/Blogs/BlogCard.dart';
import 'package:water_pathogen_detection_system/commonUtils/Constancts.dart';

class Blogs extends StatefulWidget {
  const Blogs({super.key});

  @override
  State<Blogs> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<Blogs> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final String admin_id = "malikabdullah130037@gmail.com";
  final String admin_id = "Malik@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: true
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddBlogs()),
                );
              },
              backgroundColor: primaryColor,
              shape: const CircleBorder(), // Set the background color directly
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            )
          : null,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              FontAwesomeIcons.arrowLeft,
              size: 24,
              color: primaryColor,
            )),
        centerTitle: true,
        title: const Text("Blogs"),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("Blogs posts").snapshots(),
          builder: ((context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            }
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: ((context, index) => BlogsCard(
                      snap: snapshot.data!.docs[index].data(),
                    )));
          })),
    );
  }
}
