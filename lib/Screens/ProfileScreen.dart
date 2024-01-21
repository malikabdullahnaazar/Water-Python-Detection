import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:water_pathogen_detection/Screens/ProfileScreenPages/ContactUs.dart';
import 'package:water_pathogen_detection/Screens/ProfileScreenPages/FAQ.dart';
import 'package:water_pathogen_detection/Screens/ProfileScreenPages/Help.dart';
import 'package:water_pathogen_detection/commonUtils/Constancts.dart';

class ProfleScreen extends StatefulWidget {
  const ProfleScreen({super.key});

  @override
  State<ProfleScreen> createState() => _ProfleScreenState();
}

class _ProfleScreenState extends State<ProfleScreen> {
  final List<Map<String, dynamic>> data2 = [
    {"icon": Icons.leaderboard, "heading1": "Results", "heading2": "216"},
    {"icon": Icons.check, "heading1": "Accuracy", "heading2": "100%"},
    {"icon": Icons.verified_rounded, "heading1": "Detected", "heading2": "20"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                FontAwesomeIcons.arrowLeft,
                size: 24,
                color: Colors.white,
              )),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height,
              decoration: const BoxDecoration(
                  gradient:
                      LinearGradient(colors: [primaryColor, secondaryColor]),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                          image: AssetImage('assets/images/img_image_16.png'),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Malik Abdullah',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Text(
                    'malikabdullah@gmail.com',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 330,
                        height: 60,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: data2.length,
                          itemBuilder: (context, index) => Container(
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
                      child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.white),
                    child: CustomColumn(
                      data: [
                        {
                          "icon": Icons.favorite_rounded,
                          "title": "My Saved",
                          "rightIcon": Icons.chevron_right,
                          "onClick": () => {}
                        },

                        {
                          "icon": Icons.settings,
                          "title": "Setting",
                          "rightIcon": Icons.chevron_right,
                          "onClick": () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ContactUs()))
                        },
                        {
                          "icon": Icons.contact_mail,
                          "title": "Contact us",
                          "rightIcon": Icons.chevron_right,
                          "onClick": () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ContactUs()))
                        },
                        {
                          "icon": Icons.question_answer,
                          "title": "FAQ",
                          "rightIcon": Icons.chevron_right,
                          "onClick": () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) => FAQ()))
                        },
                        {
                          "icon": Icons.help,
                          "title": "Help",
                          "rightIcon": Icons.chevron_right,
                          "onClick": () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Help()))
                        },

                        // Add more items as needed
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ],
        ));
  }
}

class CustomColumn extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const CustomColumn({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (var item in data)
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 4),
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
                    child: Icon(item["icon"] as IconData, size: 20)),
                title: Text(
                  item["title"] as String,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 87, 85, 85)),
                ),
                trailing: Icon(
                  item["rightIcon"] as IconData,
                  size: 28,
                  color: Color.fromARGB(255, 87, 85, 85),
                ),
              ),
            ),
          )
      ],
    );
  }
}
