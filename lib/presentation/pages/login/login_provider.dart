// ignore_for_file: file_names

import 'package:everyones_tone/app/utils/firestore_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

///
/// User Login Status 관리
///

class LoginProvider with ChangeNotifier {
  User? _user;
  User? get user => _user;
  final FirestoreData firestoreData = FirestoreData();

  void setUserData(User? user) async {
    _user = user;
    if (_user != null) {
      notifyListeners(); 
    }
  }
}
