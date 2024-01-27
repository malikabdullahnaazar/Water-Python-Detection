import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:water_pathogen_detection_system/FirebaseServices/FirebaseServices.dart';
import 'package:water_pathogen_detection_system/Screens/LoginScreen.dart';
import 'package:water_pathogen_detection_system/commonUtils/InputField.dart';
import 'package:water_pathogen_detection_system/Screens/HomeScreen2.dart';
import 'package:water_pathogen_detection_system/commonUtils/constancts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  TextEditingController _userController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  FirebaseServices _auth = FirebaseServices();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _userController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    String username = _userController.text;
    String password = _passwordController.text;
    String email = _emailController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Validate the input
    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      // Show appropriate Snack Bar based on validation result
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("All fields are required"),
        ),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Passwords do not match"),
        ),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Create the user
    User? user = await _auth.signUpwithEmailAndpassword(email, password);
    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Successfully registered"),
        ),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Registration Successful'),
        backgroundColor: const Color.fromARGB(255, 99, 95, 61),
        showCloseIcon: true,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: Try again"),
        ),
      );
      setState(() {
        _isLoading = false;
      });
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
                'Create Your\nAccount',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InputField(
                          controller: _userController,
                          lbltxt: 'Full Name',
                          hnttxt: '',
                          icon: Icons.keyboard,
                          kybrdtype: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InputField(
                          controller: _emailController,
                          lbltxt: 'Email',
                          hnttxt: 'Enter Email',
                          icon: Icons.person,
                          kybrdtype: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InputField(
                          controller: _passwordController,
                          lbltxt: 'Password',
                          hnttxt: 'Enter Password',
                          icon: Icons.visibility_off,
                          kybrdtype: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InputField(
                          controller: _confirmPasswordController,
                          lbltxt: 'Confirm Password',
                          hnttxt: 'Enter RePassword',
                          icon: Icons.visibility_off,
                          kybrdtype: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            _signUp(context);
                          },
                          child: Container(
                            height: 55,
                            width: 300,
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
                                      'SIGN UP',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Already have an account? Login here.',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        // Copyright Section
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(15),
                          child: const Center(
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage(
                                    "assets/images/logo-removebg-preview.png",
                                  ),
                                  width: 70,
                                  color: Colors.black,
                                  height: 70,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '© 2024 Water Pathogen Detection. All rights reserved.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
