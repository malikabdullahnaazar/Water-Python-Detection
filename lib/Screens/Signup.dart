import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:larvae_classification/FirebaseServices/FirebaseServices.dart';
import 'package:larvae_classification/commonUtils/Buton.dart';
import 'package:larvae_classification/commonUtils/InputField.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _userController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FirebaseServices _auth = FirebaseServices();
  void backToLogin() {
    Navigator.pop(context);
  }

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
     print(email);
    User? user = await _auth.signUpwithEmailAndpassword(email, password);
    if (user != null) {
      print("success");
    } else {
   
      print("hi");
    
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: SafeArea(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.black,
                        Colors.red,
                      ],
                    )),
                    child: Column(
                      children: [
                        const SizedBox(
                          width: 200, // Set the width of the container
                          height: 250, // Set the height of the container
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('images/loginImage.jpg'),
                            radius: 12,
                          ), // Image inside the container
                        ),
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InputField(
                              controller: _userController,
                              lbltxt: 'Username',
                              hnttxt: 'Enter Username',
                              icon: Icons.keyboard,
                              kybrdtype: TextInputType.text,
                            )),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InputField(
                            controller: _emailController,
                            lbltxt: 'Email',
                            hnttxt: 'Enter Email',
                            icon: Icons.person,
                            kybrdtype: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InputField(
                              controller: _passwordController,
                              lbltxt: 'Password',
                              hnttxt: 'Enter Password',
                              icon: Icons.keyboard,
                              kybrdtype: TextInputType.text,
                            )),
                        const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: InputField(
                              lbltxt: ' Confirm  Password',
                              hnttxt: 'Enter RePassword',
                              icon: Icons.keyboard,
                              kybrdtype: TextInputType.text,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: backToLogin,
                                child: const Text(
                                  'Already have account? ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300),
                                ))
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Button(btntxt: 'SignUp', onPressed: SignUp)),
                      ],
                    )))));
  }
}
