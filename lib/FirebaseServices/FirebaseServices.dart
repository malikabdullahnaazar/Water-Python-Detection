// ignore_for_file: file_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:water_pathogen_detection_system/commonUtils/Utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authChanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firestore.collection('users').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'profilePhoto': user.photoURL,
          });
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      res = false;
    }
    return res;
  }

  Future<User?> signInwithEmailAndpassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      // Show a Snackbar with the error message
      showErrorMessageSnackbar(e.toString());
      return null;
    }
  }

  // Function to show a Snackbar with an error message
  void showErrorMessageSnackbar(String errorMessage) {
    // Get the current context (you may need to pass this as a parameter)
    BuildContext? context;

    // Show a Snackbar with the error message
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        content: Text('Error: $errorMessage'),
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<bool> signOut(context) async {
    try {
      await _auth.signOut();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Logout Successfully'),
        backgroundColor: Color.fromARGB(255, 99, 95, 61),
        showCloseIcon: true,
      ));
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Logout Faild'),
        backgroundColor: Color.fromARGB(255, 99, 95, 61),
        showCloseIcon: true,
      ));
      if (kDebugMode) {
        print("aaaa${e.toString()}");
      }
      return false;
    }
  }

  Future<User?> signUpwithEmailAndpassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      SnackBar(content: Text(e.toString()));
      return null;
    }
  }
}
