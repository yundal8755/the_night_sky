// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/service/firebase_service.dart';
import 'package:everyones_tone/data/model/chat_message_model.dart';

class ChatRemoteDataSource {
  ChatRemoteDataSource(this.firebaseService);

  final FirebaseService firebaseService;

  FirebaseFirestore get _firestore => firebaseService.firestoreInstance;

  CollectionReference<Map<String, dynamic>> get _chatCollection =>
      firebaseService.chatsCollection;

  /// 채팅 메시지 업로드
  Future<void> uploadChatMessage(ChatMessageModel chatMessageModel) async {
    var messageCollection = _chatCollection
        .doc(chatMessageModel.chatId)
        .collection(FirestoreSubCollection.message.name);

    await messageCollection.add(chatMessageModel.toMap());
    print('ChatRoomRepository 실행 완료!');
  }

  /// 채팅 썸네일 목록 스트림
  Stream<List<Map<String, dynamic>>> fetchChatInfoStream() async* {
    final currentUserEmail = firebaseService.currentUserEmailValue;
    if (currentUserEmail == null) {
      yield [];
      return;
    }

    await for (var snapshot in _firestore
        .collection(FirestoreCollection.user.name)
        .doc(currentUserEmail)
        .collection(FirestoreSubCollection.myChat.name)
        .snapshots()) {
      List<Map<String, dynamic>> chatDataList = [];

      for (var myChatDoc in snapshot.docs) {
        var chatId = myChatDoc.id;
        try {
          var chatDocSnapshot = await _chatCollection.doc(chatId).get();
          var chatData = chatDocSnapshot.data();
          if (chatData != null) {
            chatData['chatId'] = chatId; // 채팅 ID도 추가
            chatDataList.add(chatData);
          } else {
            print("No data available for chat ID: $chatId");
          }
        } catch (e) {
          print("Error fetching data for chat ID: $chatId, Error: $e");
        }
      }

      yield chatDataList;
    }
  }

  /// 채팅 메시지 수 조회
  Future<int> fetchMessageCount(String chatId) async {
    var messageCollection = _chatCollection
        .doc(chatId)
        .collection(FirestoreSubCollection.message.name);
    var snapshot = await messageCollection.get();
    return snapshot.docs.length;
  }

  /// 채팅 메시지 스트림
  Stream<List<ChatMessageModel>> chatMessagesStream(String chatId) {
    return _chatCollection
        .doc(chatId)
        .collection(FirestoreSubCollection.message.name)
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

  /// 메시지 정렬
  Future<void> fetchMessageOrder(String chatId) async {
    CollectionReference messages = _chatCollection
        .doc(chatId)
        .collection(FirestoreSubCollection.message.name);

    await messages
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

  /// 메시지 업로드 (오디오 업로드 포함)
  Future<void> uploadChatMessageWithAudio({
    required String chatId,
    required String localAudioUrl,
    required String dateCreated,
    required String userEmail,
  }) async {
    String replyUserAudioUrl = await firebaseService.uploadAudioFileInstance(
      localPath: localAudioUrl,
      contentType: 'audio/x-m4a',
    );
    if (replyUserAudioUrl.isEmpty) {
      print('오디오 파일 업로드 실패');
      return;
    }

    ChatMessageModel messageModel = ChatMessageModel(
      chatId: chatId,
      audioUrl: replyUserAudioUrl,
      dateCreated: dateCreated,
      userEmail: userEmail,
    );

    await uploadChatMessage(messageModel);
  }

  /// 메시지 삭제
  Future<void> deleteChatRoom(Map<String, dynamic> chatData) async {
    try {
      var chatDocRef = _chatCollection.doc(chatData['chatId']);

      var messagesSnapshot = await chatDocRef
          .collection(FirestoreSubCollection.message.name)
          .get();
      for (var message in messagesSnapshot.docs) {
        await message.reference.delete();
      }

      await chatDocRef.delete();

      await _firestore
          .collection(FirestoreCollection.user.name)
          .doc(chatData['postUserEmail'])
          .collection(FirestoreSubCollection.myChat.name)
          .doc(chatData['chatId'])
          .delete();
      await _firestore
          .collection(FirestoreCollection.user.name)
          .doc(chatData['replyUserEmail'])
          .collection(FirestoreSubCollection.myChat.name)
          .doc(chatData['chatId'])
          .delete();

      print("채팅방 및 메시지 삭제 성공: ${chatData['chatId']}");
    } catch (e) {
      print("채팅방 삭제 에러: $e");
    }
  }
}
