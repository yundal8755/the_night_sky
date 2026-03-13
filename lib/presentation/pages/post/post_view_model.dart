// ignore_for_file: avoid_print

import 'package:everyones_tone/app/service/firebase_service.dart';
import 'package:everyones_tone/data/post/dto/post_model.dart';
import 'package:everyones_tone/data/post/post_repository.dart';
import 'package:intl/intl.dart';

class PostViewModel {
  final PostRepository postRemoteRepository = PostRepository();

  //! 입력받은 정보를 Firestore에 업로드
  Future<void> uploadPost(
      {required String postTitle,
      required String localAudioUrl,
      required String userEmail,
      required String nickname,
      required String profilePicUrl}) async {
    String audioUrl = await FirebaseService.uploadAudioFile(
      localPath: localAudioUrl,
      contentType: 'audio/x-m4a',
    );
    if (audioUrl.isEmpty) {
      print('오디오 파일 업로드 실패');
      return;
    }

    String dateCreated = DateFormat("MM/dd HH:mm:ss").format(DateTime.now());
    PostModel postModel = PostModel(
        nickname: nickname,
        postTitle: postTitle,
        audioUrl: audioUrl,
        userEmail: userEmail,
        profilePicUrl: profilePicUrl,
        dateCreated: dateCreated,
        boardName: '자유게시판');

    print('PostViewModel 실행 완료!');
    await postRemoteRepository.uploadPostRemote(postModel);
  }
}
