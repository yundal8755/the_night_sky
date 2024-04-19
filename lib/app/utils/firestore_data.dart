import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreData {
  FirestoreData._(); // Private constructor

  static final FirebaseAuth _authInstance = FirebaseAuth.instance;
  static User? get currentUser => _authInstance.currentUser;
  static String? get currentUserEmail => currentUser?.email;

  static Future<Map<String, dynamic>?> fetchUserData() async {
    final userEmail = currentUserEmail;
    if (userEmail != null) {
      final userDoc = FirebaseFirestore.instance.collection('user').doc(userEmail);
      final doc = await userDoc.get();
      return doc.data();
    }
    return null;
  }
}
