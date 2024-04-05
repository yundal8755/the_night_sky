import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/models/user_model.dart';
import 'package:everyones_tone/app/utils/firestore_data.dart';

class RegisterProfileRemoteRepository {
  final currentUser = FirestoreData().currentUser;
  final currentUserEmail = FirestoreData().currentUserEmail;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerUserData(UserModel userdata) async {
    DocumentReference userRef = _firestore.collection('user').doc(currentUserEmail);

    await userRef.set(userdata.toMap());
  }
}
