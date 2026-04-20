// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/di/service_locator.dart';
import 'package:everyones_tone/app/util/app_log.dart';
import 'package:everyones_tone/data/model/post_model.dart';
import 'package:everyones_tone/data/model/upload_post_result.dart';
import 'package:everyones_tone/app/service/firebase_service.dart';
import 'package:intl/intl.dart';

///
/// 게시글 관련 원격 데이터 소스
///
class PostRemoteDataSource {
  PostRemoteDataSource();

  final firebaseService = getIt<FirebaseService>();

  /// 게시글 업로드 (documentId 반환)
  Future<String> uploadPostRemote(PostModel postModel) async {
    DocumentReference<PostModel> userRef =
        firebaseService.postsCollection.doc();

    await userRef.set(postModel);
    AppLog.d('PostRemoteDataSource uploadPostRemote 실행 완료!');
    AppLog.d('CurrentDocument ID : ${userRef.id}');
    return userRef.id;
  }

  /// 게시글 스트림
  Stream<QuerySnapshot<PostModel>> postsStream() {
    return firebaseService.postsCollection
        .orderBy('dateCreated', descending: true)
        .snapshots();
  }

  /// 게시글 업로드
  Future<UploadPostResult?> uploadPost({
    required String postTitle,
    required String localAudioUrl,
    required String userEmail,
    required String nickname,
    required String profilePicUrl,
  }) async {
    String audioUrl = await firebaseService.uploadAudioFileInstance(
      localPath: localAudioUrl,
      contentType: 'audio/x-m4a',
    );
    if (audioUrl.isEmpty) {
      // TODO : 임시 더미 URL 제거
      AppLog.e('⚠️ 오디오 파일 업로드 실패. 테스트를 위해 임시 더미 URL을 사용합 니다.');
      audioUrl =
          'https://firebasestorage.googleapis.com/v0/b/everyones-tone.appspot.com/o/audio_url%2Fdummy.m4a?alt=media';
    }

    String dateCreated = DateFormat("MM/dd HH:mm:ss").format(DateTime.now());
    PostModel postModel = PostModel(
      nickname: nickname,
      postTitle: postTitle,
      audioUrl: audioUrl,
      userEmail: userEmail,
      profilePicUrl: profilePicUrl,
      dateCreated: dateCreated,
      boardName: '자유게시판',
    );

    print('PostRepository 실행 완료!');
    final documentId = await uploadPostRemote(postModel);
    return UploadPostResult(
      documentId: documentId,
      audioUrl: audioUrl,
      dateCreated: dateCreated,
    );
  }
}
