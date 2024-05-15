import 'package:everyones_tone/app/repository/firestore_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUserProvider with ChangeNotifier {
  Map<String, dynamic>? userData;

  FirestoreUserProvider() {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user != null) {
        FirebaseFirestore.instance
            .collection('user')
            .doc(FirestoreData.currentUserEmail)
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
