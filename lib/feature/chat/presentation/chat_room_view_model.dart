// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/feature/chat/domain/chat_message_model.dart';
import 'package:everyones_tone/feature/chat/data/chat_room_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatRoomViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ChatRoomRepository chatRoomRepository = ChatRoomRepository();
  FirebaseStorage storage = FirebaseStorage.instance;

  Stream<List<ChatMessageModel>> chatMessagesStream(String chatId) {
    return _firestore
        .collection('chat')
        .doc(chatId)
        .collection('message')
        .orderBy('dateCreated', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ChatMessageModel(
          chatId: doc.data()['chatId'] ?? '',
          audioUrl: doc.data()['audioUrl'] ?? '',
          dateCreated: doc.data()['dateCreated'] ?? '',
          userEmail: doc.data()['userEmail'] ?? '',
        );
      }).toList();
    });
  }

  //! Order
  void fetchMessageOrder(String chatId) {
    // Firestore 인스턴스 생성
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // 특정 채팅방의 메시지 컬렉션 참조
    CollectionReference messages = firestore
        .collection('chatCollection')
        .doc(chatId)
        .collection('message');

    // dateCreated 필드를 기준으로 내림차순으로 메시지 정렬
    messages
        .orderBy('dateCreated', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        print(doc["dateCreated"]); // 날짜 확인
        print(doc["userEmail"]); // 사용자 이메일 출력
        print(doc["audioUrl"]); // 오디오 URL 출력
      }
    }).catchError((error) {
      print("Error getting documents: $error");
    });
  }

  //! Upload
  Future<void> uploadChatMessage(String chatId, String localAudioUrl,
      String dateCreated, String userEmail) async {
    /// 오디오 URL 변환
    String replyUserAudioUrl =
        await convertLocalAudioToStorageUrl(localAudioUrl);
    if (replyUserAudioUrl.isEmpty) {
      print('오디오 파일 업로드 실패');
      return;
    }

    ChatMessageModel messageModel = ChatMessageModel(
        chatId: chatId,
        audioUrl: replyUserAudioUrl,
        dateCreated: dateCreated,
        userEmail: userEmail);

    await chatRoomRepository.uploadChatMessage(messageModel);
  }

  //! Delete
  Future<void> deleteChatRoom(Map<String, dynamic> chatData) async {
    try {
      // Firestore 인스턴스
      var chatDocRef = _firestore.collection('chat').doc(chatData['chatId']);

      // 'message' 서브컬렉션 내의 모든 문서를 가져옵니다.
      var messagesSnapshot = await chatDocRef.collection('message').get();
      for (var message in messagesSnapshot.docs) {
        await message.reference.delete();
      }

      // 채팅방 문서 자체를 삭제합니다.
      await chatDocRef.delete();

      // 각 사용자의 myChat 목록에서 채팅방을 삭제합니다.
      await _firestore
          .collection('user')
          .doc(chatData['postUserEmail'])
          .collection('myChat')
          .doc(chatData['chatId'])
          .delete();
      await _firestore
          .collection('user')
          .doc(chatData['replyUserEmail'])
          .collection('myChat')
          .doc(chatData['chatId'])
          .delete();

      print("채팅방 및 메시지 삭제 성공: ${chatData['chatId']}");
    } catch (e) {
      print("채팅방 삭제 에러: $e");
    }
  }

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
}
