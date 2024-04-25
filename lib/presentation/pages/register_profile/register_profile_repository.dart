// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/models/user_model.dart';
import 'package:everyones_tone/app/repository/database_helper.dart';

class RegisterProfileRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final DatabaseHelper databaseHelper = DatabaseHelper();

  //! Firestore
  Future<void> registerUserDataRemote(UserModel userModel) async {
    DocumentReference userRef =
        firestore.collection('user').doc(userModel.userEmail);
    await userRef.set(userModel.toMap());
  }

  //! SQflite
  Future<int> registerUserDataLocal(UserModel userModel) async {
    final db = await databaseHelper.database;

    print('===== user Table 만들기 성공! =====');
    return await db.insert('user', userModel.toMap());
  }
}
