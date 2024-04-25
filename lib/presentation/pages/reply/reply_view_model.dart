// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/models/chat_model.dart';
import 'package:everyones_tone/app/models/message_model.dart';
import 'package:everyones_tone/presentation/pages/reply/reply_repository.dart';
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
          'audio_url/${DateTime.now().millisecondsSinceEpoch}.mp4';
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
      required String replyDocmentId}) async {
    /// Firestore 객체 생성
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    /// ReplyUser 변수 설정
    String replyUserAudioUrl =
        await convertLocalAudioToStorageUrl(localAudioUrl);
    if (replyUserAudioUrl.isEmpty) {
      print('오디오 파일 업로드 실패');
      return;
    }
    String replyUserNickname = replyUserData['nickname'] ?? '';
    String replyUserEmail = replyUserData['userEmail'] ?? '';
    String replyUserProfilePicUrl = replyUserData['profilePicUrl'] ?? '';
    String dateCreated = DateFormat("yyyy'년' MM'월' dd'일' HH'시' mm'분' ss'초'")
        .format(DateTime.now());

    /// 최초 메신저의 post data 가져오기
    DocumentSnapshot postUserInfo =
        await firestore.collection('post').doc(replyDocmentId).get();

    /// Chat Model 생성
    ChatModel chatModel = ChatModel(
        postUserNickname: postUserInfo['nickname'],
        postUserEmail: postUserInfo['userEmail'],
        postUserProfilePicUrl: postUserInfo['profilePicUrl'],
        postTitle: postUserInfo['postTitle'],
        replyUserNickname: replyUserNickname,
        replyUserEmail: replyUserEmail,
        replyUserProfilePicUrl: replyUserProfilePicUrl,
        dateCreated: dateCreated);

    /// Post Message Model 생성
    MessageModel postMessageModel = MessageModel(
        audioUrl: postUserInfo['audioUrl'],
        dateCreated: postUserInfo['dateCreated'],
        userEmail: postUserInfo['userEmail']);

    MessageModel replyMessageModel = MessageModel(
        audioUrl: replyUserAudioUrl,
        dateCreated: dateCreated,
        userEmail: replyUserEmail);

    print('ReplyViewModel 실행 완료!');

    /// Firestore 업로드
    await replyRemoteRepository.uploadReplyRemote(
        chatModel, postMessageModel, replyMessageModel);

    /// SQflite 업로드
    await replyRemoteRepository.uploadReplyLocal(
        chatModel, postMessageModel, replyMessageModel);
  }
}
