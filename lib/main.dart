import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:water_pathogen_detection_system/Screens/HomeScreen2.dart';
import 'package:water_pathogen_detection_system/Screens/WelcomeScreen.dart';
import 'package:water_pathogen_detection_system/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Pathogen Detection',
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        // Check the login status here using FirebaseAuth
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the user is logged in, navigate to HomeScreen
            return snapshot.data != null && snapshot.data == true
                ? const HomeScreen2()
                : WelcomeScreen();
          } else {
            // Show a loading indicator while checking login status
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<bool> checkLoginStatus() async {
    try {
      // Using FirebaseAuth to check if the user is already signed in
      User? user = FirebaseAuth.instance.currentUser;

      // Return true if the user is logged in, false otherwise
      return user != null ? true : false;
    } catch (e) {
      // Handle any errors that might occur while checking login status
      if (kDebugMode) {
        print('Error checking login status: $e');
      }
      return false;
    }
  }
}
