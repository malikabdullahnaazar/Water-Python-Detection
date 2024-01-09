import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInwithEmailAndpassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("${e.toString()}");
    }
  }

  Future<User?> signUpwithEmailAndpassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
