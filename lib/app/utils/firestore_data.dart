// ignore_for_file: camel_case_types, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreData {
  final currentUser = FirebaseAuth.instance.currentUser;
  final currentUserEmail = FirebaseAuth.instance.currentUser?.email!;

  Future<Map<String, dynamic>?> fetchUserData() async {
    if (currentUser != null) {
      final userDoc =
          FirebaseFirestore.instance.collection('user').doc(currentUserEmail);
      final doc = await userDoc.get();
      return doc.data();
    }
    return null;
  }
}
