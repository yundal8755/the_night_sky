import 'package:everyones_tone/data/model/user_model.dart';
import 'package:everyones_tone/app/service/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterProfileRepository {
  //! Firestore
  Future<void> registerUserDataRemote(UserModel userModel) async {
    DocumentReference<UserModel> userRef =
        FirebaseService.users.doc(userModel.userEmail);
    await userRef.set(userModel);
  }
}
