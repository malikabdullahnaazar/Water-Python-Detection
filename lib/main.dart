import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:water_pathogen_detection/Screens/WelcomeScreen.dart';
// import 'package:water_pathogen_detection/Screens/LoginScreen.dart';
// import 'package:water_pathogen_detection/Screens/Signup.dart';
// import 'package:camera/camera.dart';
import 'package:water_pathogen_detection/firebase_options.dart';

// List<CameraDescription> cameras;

void main() async {
  late final FirebaseApp app;
  late final FirebaseAuth auth;
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  auth = FirebaseAuth.instanceFor(app: app);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: ('inter'),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}
