// ignore_for_file: avoid_print

import 'package:everyones_tone/app/di/service_locator.dart';
import 'package:everyones_tone/data/model/upload_post_result.dart';
import 'package:everyones_tone/data/remote_datasource/post_remote_data_source.dart';

///
/// 게시글 뷰모델
///
class PostViewModel {
  final postRemoteDataSource = getIt<PostRemoteDataSource>();

  /// 입력받은 정보를 Firestore에 업로드
  Future<UploadPostResult?> uploadPost({
    required String postTitle,
    required String localAudioUrl,
    required String userEmail,
    required String nickname,
    required String profilePicUrl,
  }) async {
    return await postRemoteDataSource.uploadPost(
      postTitle: postTitle,
      localAudioUrl: localAudioUrl,
      userEmail: userEmail,
      nickname: nickname,
      profilePicUrl: profilePicUrl,
    );
  }
}
