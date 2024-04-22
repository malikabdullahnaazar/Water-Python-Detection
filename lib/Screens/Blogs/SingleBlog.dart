// ignore_for_file: file_names, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:Pathogen/FirebaseServices/FireStore.dart';
import 'package:Pathogen/commonUtils/Constancts.dart';
import 'package:Pathogen/commonUtils/SnakBar.dart';

class SingleBlog extends StatelessWidget {
  final String? photoUrl;
  final String? title;
  final String? description;
  final String postId;
  final String admin_id = "malikabdullah130037@gmail.com";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirestoreMethods _firestore = FirestoreMethods();
  SingleBlog(
      {this.photoUrl,
      this.title,
      this.description,
      super.key,
      required this.postId});
// Add this function to the _BlogsScreenState class in Blogs.dart to implement record deletion with confirmation dialog

  Future<void> _deleteRecord(String postId, BuildContext context) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this Blog?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      bool res = await _firestore.deleteBlogPost(postId);
      if (res) {
        // ignore: use_build_context_synchronously
        ShowSnackBar("Blog deleted successfully", context);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
      // Perform deletion logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            FontAwesomeIcons.arrowLeft,
            size: 24,
            color: primaryColor,
          ),
        ),
        title: Text(
          title ?? "Blog",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: _auth.currentUser?.email == admin_id
            ? [
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _deleteRecord(postId, context);
                  },
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(photoUrl ?? ''),
                    fit: BoxFit.fitWidth,
                  ),
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title ?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  description ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
