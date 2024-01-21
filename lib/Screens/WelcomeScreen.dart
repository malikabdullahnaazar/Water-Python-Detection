import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:water_pathogen_detection/Screens/HomeScreen2.dart';
import 'SignUpScreen2.dart';
import 'LoginScreen.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  Future<bool> _handleGoogleSignIn() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        // Successfully signed in, now obtain the GoogleSignInAuthentication
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        // Get the Google sign-in credentials
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // Sign in to Firebase with the Google credentials
        // Replace this with your Firebase authentication logic
        // Example: await FirebaseAuth.instance.signInWithCredential(credential);

        // If Firebase sign-in is successful, return true
        return true;
      } else {
        // User canceled the sign-in process
        print('Google Sign-In canceled');
        return false;
      }
    } catch (error) {
      print('Error during Google Sign-In: $error');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 52, 170, 162),
          Color(0xff281537),
        ])),
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Image(
                image: AssetImage('assets/images/img_flutter_logo.gif'),
                height: 200,
                width: 200),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Welcome Back',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: Container(
              height: 53,
              width: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
              ),
              child: const Center(
                child: Text(
                  'SIGN IN',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const RegScreen()));
            },
            child: Container(
              height: 53,
              width: 320,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
              ),
              child: const Center(
                child: Text(
                  'SIGN UP',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Login with Social Media',
            style: TextStyle(fontSize: 17, color: Colors.white),
          ), //
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 80,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        colors: <Color>[
                          Color.fromARGB(255, 52, 170, 162),
                          Color.fromARGB(255, 14, 11, 16),
                        ],
                      ).createShader(bounds);
                    },
                    child: const Icon(
                      FontAwesomeIcons.facebookF,
                      size: 24.0,
                    )),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    bool signInSuccess = await _handleGoogleSignIn();
                    if (signInSuccess) {
                      // Navigate to HomeScreen2
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen2()),
                      );
                    }
                  } catch (error) {
                    print('Error during Google Sign-In: $error');
                  }
                },
                child: Container(
                  height: 40,
                  width: 80,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        colors: <Color>[
                          Color.fromARGB(255, 52, 170, 162),
                          Color.fromARGB(255, 14, 11, 16),
                        ],
                      ).createShader(bounds);
                    },
                    child: const Icon(
                      FontAwesomeIcons.google,
                      size: 20.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
