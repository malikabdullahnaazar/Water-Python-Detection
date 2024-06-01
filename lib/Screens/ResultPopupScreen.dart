import 'package:Pathogen/Screens/HomeScreen2.dart';
import 'package:flutter/material.dart';
import 'package:Pathogen/commonUtils/Constancts.dart';

class ResultPopupScreen extends StatelessWidget {
  final bool isSuccess;

  const ResultPopupScreen({
    super.key,
    required this.isSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [primaryColor, secondaryColor]),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isSuccess ? Icons.check_circle : Icons.error,
                  color: isSuccess ? Colors.green : Colors.red,
                  size: 100,
                ),
                const SizedBox(height: 20),
                Text(
                  isSuccess
                      ? 'Detection Successful'
                      : 'Please upload a clear image.',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
