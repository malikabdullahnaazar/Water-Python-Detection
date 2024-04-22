// ignore_for_file: file_names, use_function_type_syntax_for_parameters

import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:Pathogen/FirebaseServices/Storage.dart';
import 'package:Pathogen/Screens/User/BlogsUser.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<bool> deletePrediction(String predictionId) async {
    try {
      // Get the document reference for the prediction using predictionId
      final predictionRef =
          _firestore.collection("Predictions").doc(predictionId);

      // Delete the document from Firestore
      await predictionRef.delete();
      return true;
    } catch (err) {
      if (kDebugMode) {
        print("Error deleting prediction: $err");
      }
      return false;

      // Handle error as needed
    }
  }

  Future<String> storePrediction(
      String label, double confidence, Uint8List picture, prediction) async {
    String res = "Some error can be occur";
    try {
      String photoUrl =
          await StorageMethod().BlogImage("Predictions", picture, true);
      String predictionId = const Uuid().v1();

      // Additional data you may want to store
      DateTime predictionDate = DateTime.now();
      String userId = auth.currentUser!.uid; // Assuming user authentication

      // Create a model or map to store the prediction data
      Map<String, dynamic> predictionData = {
        'label': label,
        'confidence': confidence,
        'photoUrl': photoUrl,
        'predictionId': predictionId,
        'predictionDate': predictionDate,
        'userId': userId,
        "prediction": prediction,
        // Add more fields as needed
      };

      await _firestore
          .collection("Predictions")
          .doc(predictionId)
          .set(predictionData);
      res = "Results Saveded successfully..";
    } catch (err) {
      if (kDebugMode) {
        print("Error storing prediction: $err");
      }
      // Handle error as needed
    }
    return res;
  }

  Future<String> uploadBlogs(
      String description, Uint8List file, String title) async {
    String res = "Some error can be occur";

    try {
      String photoUrl = await StorageMethod().BlogImage("Blogs", file, true);
      String postId = const Uuid().v1();
      BlogsUser post = BlogsUser(
        description: description,
        title: title,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
      );
      await _firestore.collection("Blogs posts").doc(postId).set(post.ToJSON());
      res = "Success";
    } catch (err) {
      res = err.toString();
      return res;
    }
    return res;
  }

  Future<bool> deleteBlogPost(String postId) async {
    try {
      // Get the document reference for the post using postId
      final postRef = _firestore.collection("Blogs posts").doc(postId);

      // Get the post data to retrieve the photoUrl

      // Delete the document from Firestore
      await postRef.delete();
      return true;
    } catch (err) {
      if (kDebugMode) {
        print("Error deleting post: $err");
      }
      return false;

      // Handle error as needed
    }
  }
}
