// ignore_for_file: file_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:water_pathogen_detection_system/Screens/Blogs/AddBlogs.dart';
import 'package:water_pathogen_detection_system/Screens/Blogs/BlogCard.dart';
import 'package:water_pathogen_detection_system/Screens/HomeScreen2.dart';
import 'package:water_pathogen_detection_system/Screens/ProfileScreen.dart';
import 'package:water_pathogen_detection_system/commonUtils/Constancts.dart';

class Blogs extends StatefulWidget {
  const Blogs({super.key});

  @override
  State<Blogs> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<Blogs> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String admin_id = "malikabdullah130037@gmail.com";
  // final String admin_id = "Malik@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _auth.currentUser?.email == admin_id
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
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        unselectedFontSize: 16,
        selectedFontSize: 16,
        currentIndex: 1,
        selectedItemColor: primaryColor,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined), label: 'Blogs'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen2()));
              break;
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Blogs()));
              break;
            case 2:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfleScreen()));
              break;
          }
        },
      ),
    );
  }
}
