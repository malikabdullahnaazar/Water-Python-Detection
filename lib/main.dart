import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:larvae_classification/Screens/Demo.dart';
import 'package:larvae_classification/Screens/HomeScreen2.dart';
import 'package:larvae_classification/Screens/LoginScreen.dart';
import 'package:larvae_classification/Screens/PictureScreen.dart';
import 'package:larvae_classification/Screens/ProfileScreen.dart';
import 'package:larvae_classification/Screens/WelcomeScreen.dart';
// import 'package:larvae_classification/Screens/LoginScreen.dart';
// import 'package:larvae_classification/Screens/Signup.dart';
// import 'package:camera/camera.dart';
import 'package:larvae_classification/firebase_options.dart';

// List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:  ThemeData(
        fontFamily: ('inter'),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
