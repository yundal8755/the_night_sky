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
      final userDoc =
          FirebaseFirestore.instance.collection('user').doc(userEmail);
      final doc = await userDoc.get();
      return doc.data();
    }
    return null;
  }

  static Future<bool> hasRepliedBefore(
      String userEmail, String replyDocumentId) async {
    final userDoc = await FirebaseFirestore.instance
        .collection('user')
        .doc(userEmail)
        .get();
    if (userDoc.exists) {
      final previousReplies =
          await userDoc.reference.collection('previousReplies').get();
      for (var doc in previousReplies.docs) {
        if (doc.id == replyDocumentId) {
          return true;
        }
      }
    }
    return false;
  }
}
