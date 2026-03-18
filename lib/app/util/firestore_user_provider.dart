import 'package:everyones_tone/app/service/firebase_service.dart';
import 'package:everyones_tone/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

///
/// 파이어스토어 유저 데이터 제공
///
class FirestoreUserProvider with ChangeNotifier {
  UserModel? userData;

  FirestoreUserProvider() {
    FirebaseService.auth.userChanges().listen((User? user) {
      if (user != null) {
        FirebaseService.users
            .doc(FirebaseService.currentUserEmail)
            .snapshots()
            .listen((snapshot) {
          userData = snapshot.data();
          notifyListeners();
        });
      } else {
        userData = null;
        notifyListeners();
      }
    });
  }
}
