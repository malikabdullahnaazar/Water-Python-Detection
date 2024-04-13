// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class BlogsUser {
  final String description;
  final String title;
  final String postId;
  // ignore: prefer_typing_uninitialized_variables
  final datePublished;

  final String postUrl;
  BlogsUser({
    required this.description,
    required this.title,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
  });
  // ignore: non_constant_identifier_names
  Map<String, dynamic> ToJSON() => {
        "Description": description,
        "Title": title,
        "PostId": postId,
        "DatePublished": datePublished,
        "PostUrl": postUrl,
      };

  static BlogsUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return BlogsUser(
      description: snapshot['Description'],
      title: snapshot['Title'],
      postId: snapshot['PostId'],
      datePublished: snapshot['DatePublished'],
      postUrl: snapshot['PostUrl'],
    );
  }
}
