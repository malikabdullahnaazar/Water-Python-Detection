import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:water_pathogen_detection/Screens/PictureScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:water_pathogen_detection/Screens/ProfileScreen.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  File? selectedImage;
  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          unselectedFontSize: 16,
          selectedFontSize: 19,
          selectedItemColor: const Color.fromARGB(255, 200, 24, 24),
          items: [
            BottomNavigationBarItem(
                icon: IconButton(
                    onPressed: () {
                      pickImageFromCamera();
                    },
                    icon: const Icon(Icons.home)),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: IconButton(
                    onPressed: () {
                      pickImage();
                    },
                    icon: const Icon(Icons.history_edu_rounded)),
                label: 'Hostory'),
            BottomNavigationBarItem(
                icon: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfleScreen()));
                    },
                    icon: const Icon(Icons.person)),
                label: 'Profile'),
          ]),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 350,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 52, 170, 162),
                  Color(0xff281537),
                ]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            child: const Center(
                child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Safe water, smart detection.',
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 39),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        FontAwesomeIcons.facebook,
                        color: Color.fromARGB(255, 0, 0, 0),
                        size: 30,
                      ),
                      Icon(
                        FontAwesomeIcons.github,
                        color: Color.fromARGB(255, 0, 0, 0),
                        size: 30,
                      ),
                      Icon(
                        color: Color.fromARGB(255, 0, 0, 0),
                        FontAwesomeIcons.discord,
                        size: 30,
                      )
                    ],
                  )
                ],
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 360, left: 10, right: 10, bottom: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: const EdgeInsets.symmetric(),
                    child: Text(
                      'Project Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Card(
                    elevation: 8,
                    shadowColor: Colors.grey,
                    child: Container(
                      width: 400,
                      height: 350,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    40, // Replace with the number of items you want
                                itemBuilder: (BuildContext context, int index) {
                                  return Table(
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Image.asset(
                                              'assets/images/img_flutter_logo.png',
                                              height: 65,
                                              width: 50,
                                            ),
                                          ),
                                          const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Healthy bacteria',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                'Found in healthy Water.',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future pickImage() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    print(returnImage!.path);
    if (returnImage != null) {
      setState(() {
        selectedImage = File(returnImage.path);
        image = selectedImage!.readAsBytesSync();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PictureScreen(image: image, selectedImage: selectedImage)));
      });
    } else
      return;
  }

  Future pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage != null) {
      setState(() {
        selectedImage = File(returnImage.path);
        image = selectedImage!.readAsBytesSync();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PictureScreen(image: image, selectedImage: selectedImage)));
      });
    } else
      return;
  }
}
