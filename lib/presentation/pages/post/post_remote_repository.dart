// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/models/post_model.dart';

class PostRemoteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadPost(PostModel postModel) async {
    DocumentReference userRef = _firestore.collection('post').doc();

    await userRef.set(postModel.toMap());
    print('PostRemoteRepository 실행 완료!');
  }
}
