// ignore_for_file: avoid_print

import 'dart:io';
import 'package:everyones_tone/app/models/post_model.dart';
import 'package:everyones_tone/presentation/pages/post/post_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class PostViewModel {
  final PostRepository postRemoteRepository = PostRepository();

  FirebaseStorage storage = FirebaseStorage.instance;

  //! localAudioUrl을 Firebase Storage Url로 변경
  Future<String> convertLocalAudioToStorageUrl(String localAudioUrl) async {
    File file = File(localAudioUrl);
    try {
      // Firebase Storage에 업로드할 파일의 경로를 지정
      String fileName =
          'audio_url/${DateTime.now().millisecondsSinceEpoch}.m4a';
      Reference ref = storage.ref().child(fileName);

      // 업로드 시 Metadata에 MIME 타입 설정
      SettableMetadata metadata = SettableMetadata(contentType: 'audio/x-m4a');

      // 파일 업로드 수행
      UploadTask uploadTask = ref.putFile(file, metadata);

      // 업로드 완료까지 대기
      await uploadTask.whenComplete(() => null);

      // 업로드된 파일의 URL 가져오기
      String downloadURL = await ref.getDownloadURL();

      print('downloadURL: $downloadURL');

      return downloadURL;
    } catch (e) {
      // 에러 처리
      print("오디오 파일 업로드 중 에러 발생: $e");
      return '';
    }
  }

  //! 입력받은 정보를 Firestore에 업로드
  Future<void> uploadPost(
      {required String postTitle,
      required String localAudioUrl,
      required Map<String, dynamic> userData}) async {
    String audioUrl = await convertLocalAudioToStorageUrl(localAudioUrl);
    if (audioUrl.isEmpty) {
      print('오디오 파일 업로드 실패');
      return;
    }

    String nickname = userData['nickname'] ?? '';
    String userEmail = userData['userEmail'] ?? '';
    String profilePicUrl = userData['profilePicUrl'] ?? '';
    String dateCreated = DateFormat("MM/dd HH:mm:ss").format(DateTime.now());
    PostModel postModel = PostModel(
      nickname: nickname,
      postTitle: postTitle,
      audioUrl: audioUrl,
      userEmail: userEmail,
      profilePicUrl: profilePicUrl,
      dateCreated: dateCreated,
    );

    print('PostViewModel 실행 완료!');
    await postRemoteRepository.uploadPostRemote(postModel);
  }
}
