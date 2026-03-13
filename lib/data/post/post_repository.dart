// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/data/post/dto/post_model.dart';

// TODO : Repository -> DataSource로 변경
class PostRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadPostRemote(PostModel postModel) async {
    DocumentReference userRef = _firestore.collection('post').doc();

    await userRef.set(postModel.toMap());
    print('PostRemoteRepository 실행 완료!');
  }
}
