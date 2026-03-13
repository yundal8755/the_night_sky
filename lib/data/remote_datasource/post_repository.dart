// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/data/model/post_model.dart';
import 'package:everyones_tone/app/service/firebase_service.dart';

// TODO : Repository -> DataSource로 변경
class PostRepository {
  final _firestore = FirebaseService.firestore;

  Future<void> uploadPostRemote(PostModel postModel) async {
    DocumentReference<PostModel> userRef = FirebaseService.posts.doc();

    await userRef.set(postModel);
    print('PostRemoteRepository 실행 완료!');
  }
}
