// ignore_for_file: file_names

import "package:flutter/material.dart";

// ignore: non_constant_identifier_names
ShowSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(content)),
  );
}
