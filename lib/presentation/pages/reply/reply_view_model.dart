// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/service/firebase_service.dart';
import 'package:everyones_tone/data/chat/dto/chat_model.dart';
import 'package:everyones_tone/data/chat/dto/chat_message_model.dart';
import 'package:everyones_tone/data/chat/reply_repository.dart';
import 'package:everyones_tone/data/post/dto/post_model.dart';
import 'package:everyones_tone/data/user/dto/user_model.dart';
import 'package:intl/intl.dart';

class ReplyViewModel {
  ReplyRepository replyRemoteRepository = ReplyRepository();

  //! 입력받은 정보를 DB에 업로드
  Future<void> uploadReply(
      {required String localAudioUrl,
      required UserModel replyUser,
      required String replyDocumentId}) async {
    /// 데이터 가져오기
    final DocumentSnapshot<PostModel> postUserData =
        await FirebaseService.posts.doc(replyDocumentId).get();

    /// 오디오 URL 변환
    String replyUserAudioUrl = await FirebaseService.uploadAudioFile(
      localPath: localAudioUrl,
      contentType: 'audio/x-m4a',
    );
    if (replyUserAudioUrl.isEmpty) {
      print('오디오 파일 업로드 실패');
      return;
    }

    /// Post User 데이터 설정
    final postData = postUserData.data();
    if (postData == null) {
      print('게시글 정보를 찾을 수 없습니다.');
      return;
    }

    String postAudioUrl = postData.audioUrl;
    String postDateCreated = postData.dateCreated;
    String postTitle = postData.postTitle;
    String postUserEmail = postData.userEmail;
    String postUserNickname = postData.nickname;
    String postUserProfilePicUrl = postData.profilePicUrl;

    /// Reply User 데이터 설정
    String replyUserEmail = replyUser.userEmail;
    String replyUserNickname = replyUser.nickname;
    String replyUserProfilePicUrl = replyUser.profilePicUrl;
    String dateCreated = DateFormat("MM/dd HH:mm:ss").format(DateTime.now());

    /// Chat Model 생성
    ChatModel chatModel = ChatModel(
      dateCreated: dateCreated,
      postTitle: postTitle,
      postUserEmail: postUserEmail,
      postUserNickname: postUserNickname,
      postUserProfilePicUrl: postUserProfilePicUrl,
      replyUserEmail: replyUserEmail,
      replyUserNickname: replyUserNickname,
      replyUserProfilePicUrl: replyUserProfilePicUrl,
    );

    /// Post Message Model 생성
    ChatMessageModel postMessageModel = ChatMessageModel(
        audioUrl: postAudioUrl,
        dateCreated: postDateCreated,
        userEmail: postUserEmail);

    /// Reply Message Model 생성
    ChatMessageModel replyMessageModel = ChatMessageModel(
        audioUrl: replyUserAudioUrl,
        dateCreated: dateCreated,
        userEmail: replyUserEmail);

    print('ReplyViewModel 실행 완료!');

    /// Firestore 업로드
    await replyRemoteRepository.uploadReplyRemote(
        chatModel, postMessageModel, replyMessageModel, replyDocumentId);
  }
}
