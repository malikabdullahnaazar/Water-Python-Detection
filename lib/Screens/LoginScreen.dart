import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:water_pathogen_detection/Screens/HomeScreen2.dart';
import 'package:water_pathogen_detection/Screens/SignUpScreen2.dart';
import 'package:water_pathogen_detection/commonUtils/Buton.dart';
import 'package:water_pathogen_detection/commonUtils/InputField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:water_pathogen_detection/FirebaseServices/FirebaseServices.dart';
import 'package:water_pathogen_detection/commonUtils/constancts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late FirebaseServices _auth;

  void login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Navigator.push(
    // context, MaterialPageRoute(builder: (context) => const HomeScreen2()));
    print(email + password);
    try {
      _auth = FirebaseServices();
      User? user = await _auth.signInwithEmailAndpassword(email, password);
      if (user != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen2()));
      } else {
        const SnackBar(content: Text('User not found'));
      }
    } catch (e) {
      print('abc${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              primaryColor,
              secondaryColor,
            ]),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 60.0, left: 22),
            child: Text(
              'Hello\nSign in!',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: Colors.white,
            ),
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputField(
                      controller: _emailController,
                      lbltxt: 'Email',
                      hnttxt: 'Enter Email',
                      icon: Icons.person,
                      kybrdtype: TextInputType.emailAddress,
                    ),
                    InputField(
                      lbltxt: 'Password',
                      hnttxt: 'Enter Password',
                      icon: Icons.visibility_off,
                      kybrdtype: TextInputType.text,
                      controller: _passwordController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RegScreen()));
                          },
                          child: const Text(
                            "Don't have account?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    InkWell(
                      onTap: () => login(),
                      child: Container(
                        height: 55,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(colors: [
                            primaryColor,
                            secondaryColor,
                          ]),
                        ),
                        child: const Center(
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
