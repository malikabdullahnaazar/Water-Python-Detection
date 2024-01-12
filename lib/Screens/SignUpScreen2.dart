import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:water_pathogen_detection/FirebaseServices/FirebaseServices.dart';
import 'package:water_pathogen_detection/Screens/LoginScreen.dart';
import 'package:water_pathogen_detection/commonUtils/InputField.dart';
import 'package:water_pathogen_detection/Screens/HomeScreen2.dart';

class RegScreen extends StatelessWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _userController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    FirebaseServices _auth = FirebaseServices();

    @override
    void dispose() {
      _emailController.dispose();
      _userController.dispose();
      _passwordController.dispose();
    }

    void SignUp() async {
      String username = _userController.text;
      String password = _passwordController.text;
      String email = _emailController.text;
      // print(email);
      User? user = await _auth.signUpwithEmailAndpassword(email, password);
      print(user);
      if (user != null) {
        print("success");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen2()));
      } else {
        print("hi");
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
              Color.fromARGB(255, 52, 170, 162),
              Color.fromARGB(255, 14, 11, 16),
            ]),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 60.0, left: 22),
            child: Text(
              'Create Your\nAccount',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
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
                        controller: _passwordController,
                        lbltxt: ' Confirm  Password',
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
                              Color.fromARGB(255, 52, 170, 162),
                              Color.fromARGB(255, 14, 11, 16),
                            ]),
                          ),
                          child: const Center(
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
