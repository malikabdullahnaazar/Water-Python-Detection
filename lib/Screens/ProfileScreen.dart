// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:water_pathogen_detection_system/FirebaseServices/FirebaseServices.dart';
import 'package:water_pathogen_detection_system/Screens/Blogs/Blogs.dart';
import 'package:water_pathogen_detection_system/Screens/HomeScreen2.dart';
import 'package:water_pathogen_detection_system/Screens/ProfileScreenPages/ContactUs.dart';
import 'package:water_pathogen_detection_system/Screens/ProfileScreenPages/FAQ.dart';
import 'package:water_pathogen_detection_system/Screens/ProfileScreenPages/Help.dart';
import 'package:water_pathogen_detection_system/Screens/Results.dart';
import 'package:water_pathogen_detection_system/Screens/SettingsPage.dart';
import 'package:water_pathogen_detection_system/Screens/WelcomeScreen.dart';
import 'package:water_pathogen_detection_system/commonUtils/Constancts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfleScreen extends StatefulWidget {
  const ProfleScreen({super.key});

  @override
  State<ProfleScreen> createState() => _ProfleScreenState();
}

class _ProfleScreenState extends State<ProfleScreen> {
  late FirebaseServices _auth;
  late User? _user;

  final List<Map<String, dynamic>> data2 = [
    {"icon": Icons.leaderboard, "heading1": "Results", "heading2": "216"},
    {"icon": Icons.check, "heading1": "Accuracy", "heading2": "100%"},
    {"icon": Icons.verified_rounded, "heading1": "Detected", "heading2": "20"},
  ];

  @override
  void initState() {
    super.initState();
    _auth = FirebaseServices();
    _loadUserData();
  }

  void _loadUserData() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        unselectedFontSize: 16,
        selectedFontSize: 16,
        currentIndex: 2,
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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [primaryColor, secondaryColor]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                CircleAvatar(
                  radius: 45,
                  backgroundImage: _user?.photoURL != null
                      ? NetworkImage(_user!.photoURL!)
                      : const AssetImage('assets/images/avatar.png')
                          as ImageProvider<Object>?,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  _user?.displayName ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  _user?.email ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 330,
                      height: 60,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: data2.length,
                        itemBuilder: (context, index) => SizedBox(
                          width: 100,
                          height: 60,
                          child: Column(
                            children: [
                              Icon(
                                data2[index]["icon"] as IconData,
                                size: 20,
                                color: Colors.black,
                              ),
                              Text(
                                data2[index]["heading1"],
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                data2[index]["heading2"],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            const VerticalDivider(
                          color: Colors.grey, // Customize the color as needed
                          thickness: 1, // Customize the thickness as needed
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                      child: CustomColumn(
                        data: [
                          {
                            "icon": Icons.favorite_rounded,
                            "title": "My Saved",
                            "rightIcon": Icons.chevron_right,
                            "onClick": () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MySavedResultsPage(),
                                  ),
                                ),
                          },
                          {
                            "icon": Icons.settings,
                            "title": "Setting",
                            "rightIcon": Icons.chevron_right,
                            "onClick": () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SettingsPage(),
                                  ),
                                ),
                          },
                          {
                            "icon": Icons.contact_mail,
                            "title": "Contact us",
                            "rightIcon": Icons.chevron_right,
                            "onClick": () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ContactUs(),
                                  ),
                                ),
                          },
                          {
                            "icon": Icons.question_answer,
                            "title": "FAQ",
                            "rightIcon": Icons.chevron_right,
                            "onClick": () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FAQ(),
                                  ),
                                ),
                          },
                          {
                            "icon": Icons.help,
                            "title": "Help",
                            "rightIcon": Icons.chevron_right,
                            "onClick": () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Help(),
                                  ),
                                ),
                          },
                          {
                            "icon": Icons.logout,
                            "title": "Logout",
                            "rightIcon": Icons.chevron_right,
                            "onClick": () async {
                              _auth = FirebaseServices();
                              _auth.signOut(context);

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WelcomeScreen(),
                                ),
                              );
                            },
                          },
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomColumn extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const CustomColumn({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (var item in data)
          Padding(
            padding:
                const EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 4),
            child: InkWell(
              onTap: item["onClick"],
              child: ListTile(
                leading: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: <Color>[Colors.black, Colors.black],
                    ).createShader(bounds);
                  },
                  child: Icon(item["icon"] as IconData, size: 20),
                ),
                title: Text(
                  item["title"] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 87, 85, 85),
                  ),
                ),
                trailing: Icon(
                  item["rightIcon"] as IconData,
                  size: 28,
                  color: const Color.fromARGB(255, 87, 85, 85),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
