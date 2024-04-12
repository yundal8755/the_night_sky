import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  User? _user;
  User? get user => _user;

  void setUserData(User? user) async {
    _user = user;
    if (_user != null) {
      notifyListeners();
    }
  }
}
