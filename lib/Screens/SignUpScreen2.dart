import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:water_pathogen_detection/FirebaseServices/FirebaseServices.dart';
import 'package:water_pathogen_detection/Screens/LoginScreen.dart';
import 'package:water_pathogen_detection/commonUtils/InputField.dart';
import 'package:water_pathogen_detection/Screens/HomeScreen2.dart';
import 'package:water_pathogen_detection/commonUtils/constancts.dart';

class RegScreen extends StatelessWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _userController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();
    FirebaseServices _auth = FirebaseServices();

    @override
    void dispose() {
      _emailController.dispose();
      _userController.dispose();
      _passwordController.dispose();
      _confirmPasswordController.dispose();
    }

    void SignUp() async {
      String username = _userController.text;
      String password = _passwordController.text;
      String email = _emailController.text;
      String confirmPassword = _confirmPasswordController.text;

      // Validate the input
      if (username.isEmpty) {
        const snackBar = SnackBar(
          content: Text("Please enter a username"),
          behavior: SnackBarBehavior.fixed,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      if (email.isEmpty) {
        const snackBar = SnackBar(
          content: Text("Please enter an email"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      if (password.isEmpty) {
        const snackBar = SnackBar(
          content: Text("Please enter a password"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      if (confirmPassword.isEmpty) {
        const snackBar = SnackBar(
          content: Text("Please confirm your password"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      if (password != confirmPassword) {
        const snackBar = SnackBar(
          content: Text("Passwords do not match"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      // Create the user
      User? user = await _auth.signUpwithEmailAndpassword(email, password);
      if (user != null) {
        const snackBar = SnackBar(
          content: Text("Successfully registered"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen2()));
      } else {
        const snackBar = SnackBar(
          content: Text("Error: Try again"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

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
                            SignUp();
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
                            child: const Center(
                              child: Text(
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
                                        "assets/images/logo-removebg-preview.png"),
                                    width: 70,
                                    color: Colors.black,
                                    height: 70),
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
