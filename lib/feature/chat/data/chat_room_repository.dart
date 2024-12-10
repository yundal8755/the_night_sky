// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/feature/chat/domain/chat_message_model.dart';

class ChatRoomRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadChatMessage(ChatMessageModel chatMessageModel) async {
    var messageCollection = _firestore
        .collection('chat')
        .doc(chatMessageModel.chatId)
        .collection('message');

    // 새로운 메시지 문서 생성
    await messageCollection.add(chatMessageModel.toMap());
    print('ChatRoomRepository 실행 완료!');
  }
}
