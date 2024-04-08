// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/models/post_model.dart';
import 'package:everyones_tone/presentation/pages/post/post_remote_repository.dart';

class PostViewModel {
  final PostRemoteRepository postRemoteRepository = PostRemoteRepository();

  Future<void> uploadPost(
      {required String postTitle,
      required String audioUrl,
      required Map<String, dynamic> userData}) async {
    print('PostViewModel 실행 완료!');
    print('postTitle: $postTitle');
    print('audioUrl: $audioUrl');
    print('userData: $userData');

    String nickname = userData['nickname'] ?? '';
    String userEmail = userData['userEmail'] ?? '';
    String profilePicUrl = userData['profilePicUrl'] ?? '';

    Timestamp dateCreated = Timestamp.fromDate(DateTime.now());

    PostModel postModel = PostModel(
      nickname: nickname,
      postTitle: postTitle,
      audioUrl: audioUrl,
      userEmail: userEmail,
      profilePicUrl: profilePicUrl,
      dateCreated: dateCreated,
    );

    print('PostViewModel 실행 완료!');
    await postRemoteRepository.uploadPost(postModel);
  }
}
