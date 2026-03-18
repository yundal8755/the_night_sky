// ignore_for_file: avoid_print

import 'package:everyones_tone/app/di/service_locator.dart';
import 'package:everyones_tone/data/remote_datasource/post_remote_data_source.dart';

class PostViewModel {
  PostViewModel({
    PostRemoteDataSource? postRepository,
  }) : postRemoteRepository = postRepository ?? getIt<PostRemoteDataSource>();

  final PostRemoteDataSource postRemoteRepository;

  //! 입력받은 정보를 Firestore에 업로드
  Future<void> uploadPost(
      {required String postTitle,
      required String localAudioUrl,
      required String userEmail,
      required String nickname,
      required String profilePicUrl}) async {
    await postRemoteRepository.uploadPost(
      postTitle: postTitle,
      localAudioUrl: localAudioUrl,
      userEmail: userEmail,
      nickname: nickname,
      profilePicUrl: profilePicUrl,
    );
  }
}
