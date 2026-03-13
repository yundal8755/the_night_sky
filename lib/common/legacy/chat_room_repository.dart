// ignore_for_file: avoid_print

import 'package:everyones_tone/app/service/firebase_service.dart';
import 'package:everyones_tone/common/model/chat_message_model.dart';

class ChatRoomRepository {
  final _firestore = FirebaseService.firestore;

  /// 채팅 메시지 업로드
  Future<void> uploadChatMessage(ChatMessageModel chatMessageModel) async {
    var messageCollection = _firestore
        .collection('chat')
        .doc(chatMessageModel.chatId)
        .collection('message');

    await messageCollection.add(chatMessageModel.toMap());
    print('ChatRoomRepository 실행 완료!');
  }
}
