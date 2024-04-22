// ignore_for_file: use_build_context_synchronously, file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Pathogen/Screens/HomeScreen2.dart';
import 'package:Pathogen/Screens/SignUpScreen2.dart';
import 'package:Pathogen/commonUtils/InputField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Pathogen/FirebaseServices/FirebaseServices.dart';
import 'package:Pathogen/commonUtils/constancts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late FirebaseServices _auth;
  bool _isLoading = false;

  void login() async {
    setState(() {
      _isLoading = true;
    });
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid Email or Password!"),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
    try {
      _auth = FirebaseServices();
      User? user = await _auth.signInwithEmailAndpassword(email, password);
      if (user != null) {
        Navigator.pushReplacement(
            // ignore: duplicate_ignore
            // ignore: use_build_context_synchronously
            context, // Use pushReplacement instead of push
            MaterialPageRoute(builder: (context) => const HomeScreen2()));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Login Successful'),
          backgroundColor: Color.fromARGB(255, 99, 95, 61),
          showCloseIcon: true,
        ));
      } else {
        setState(() {
          _isLoading = false;
        });
        _auth.showErrorMessageSnackbar('User not found');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Credentials or Check Internet Connection'),
          backgroundColor: Color.fromARGB(255, 99, 95, 61),
          showCloseIcon: true,
        ),
      );
      if (kDebugMode) {
        print('abcd${e.toString()}');
      }
      _auth.showErrorMessageSnackbar(e.toString());
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
                    const SizedBox(
                      height: 20,
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
                        child: Center(
                          child: _isLoading
                              ? LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.white,
                                  size: 20,
                                )
                              : const Text(
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
