// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/feature/chat/domain/chat_model.dart';
import 'package:everyones_tone/feature/chat/domain/chat_message_model.dart';
import 'package:everyones_tone/feature/chat/data/reply_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class ReplyViewModel {
  ReplyRepository replyRemoteRepository = ReplyRepository();
  FirebaseStorage storage = FirebaseStorage.instance;

  //! localAudioUrl을 Firebase Storage Url로 변경
  Future<String> convertLocalAudioToStorageUrl(String localAudioUrl) async {
    File file = File(localAudioUrl);
    try {
      // Firebase Storage에 업로드할 파일의 경로를 지정
      String fileName =
          'audio_url/${DateTime.now().millisecondsSinceEpoch}.m4a';
      Reference ref = storage.ref().child(fileName);

      // 파일 업로드 수행
      UploadTask uploadTask = ref.putFile(file);

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

  //! 입력받은 정보를 DB에 업로드
  Future<void> uploadReply(
      {required String localAudioUrl,
      required Map<String, dynamic> replyUserData,
      required String replyDocumentId}) async {
    /// 데이터 가져오기
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot postUserData =
        await firestore.collection('post').doc(replyDocumentId).get();

    /// 오디오 URL 변환
    String replyUserAudioUrl =
        await convertLocalAudioToStorageUrl(localAudioUrl);
    if (replyUserAudioUrl.isEmpty) {
      print('오디오 파일 업로드 실패');
      return;
    }

    /// Post User 데이터 설정
    String postAudioUrl = postUserData['audioUrl'];
    String postDateCreated = postUserData['dateCreated'];
    String postTitle = postUserData['postTitle'];
    String postUserEmail = postUserData['userEmail'];
    String postUserNickname = postUserData['nickname'];
    String postUserProfilePicUrl = postUserData['profilePicUrl'];

    /// Reply User 데이터 설정
    String replyUserEmail = replyUserData['userEmail'];
    String replyUserNickname = replyUserData['nickname'];
    String replyUserProfilePicUrl = replyUserData['profilePicUrl'];
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
