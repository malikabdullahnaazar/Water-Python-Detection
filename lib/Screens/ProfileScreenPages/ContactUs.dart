import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:water_pathogen_detection/commonUtils/constancts.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key});

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
          "Contact Us",
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
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "You can get in touch with us through the platforms below. Our team will reach out to you as soon as possible.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            Card(
              elevation: 8,
              shadowColor: Colors.black,
              child: Container(
                width: 400,
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Customer Support",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 200,
                        child: Row(
                          children: [
                            const CircleAvatar(
                              child: Icon(
                                FontAwesomeIcons.phone,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Contact Number",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "+923175001831",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 400,
                        child: Row(
                          children: [
                            const CircleAvatar(
                              child: Icon(
                                Icons.email,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email Address",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "pathogenhelp@gmail.com",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 8,
              shadowColor: Colors.black,
              child: Container(
                width: 400,
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Social Media",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 200,
                        child: Row(
                          children: [
                            const CircleAvatar(
                              child: Icon(
                                FontAwesomeIcons.instagram,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Instagram",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "pathogonDetection",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 400,
                        child: Row(
                          children: [
                            const CircleAvatar(
                              child: Icon(
                                FontAwesomeIcons.facebookF,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Facebook",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "PathogenDetection",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            // Copyright Section
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15),
              child: const Center(
                child: Column(
                  children: [
                    Image(
                        image: AssetImage(
                            "assets/images/logo-removebg-preview.png"),
                        width: 70,
                        color: Colors.black,
                        height: 70),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.copyright,
                          size: 15,
                          color: Colors.black,
                          weight: 66,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          " 2024 Water Pathogen Detection. All rights reserved.",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
