// ignore_for_file: file_names

import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  String _uid = '';
  String _displayName = '';
  String _email = '';
  String _photoURL = '';

  String get uid => _uid;
  String get displayName => _displayName;
  String get email => _email;
  String get photoURL => _photoURL;

  void updateUserInfo({
    required String uid,
    required String displayName,
    required String email,
    required String photoURL,
  }) {
    _uid = uid;
    _displayName = displayName;
    _email = email;
    _photoURL = photoURL;

    notifyListeners();
  }
}
