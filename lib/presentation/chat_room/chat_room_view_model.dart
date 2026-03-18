// ignore_for_file: avoid_print

import 'package:everyones_tone/data/model/chat_message_model.dart';
import 'package:everyones_tone/data/remote_datasource/chat_remote_data_source.dart';

class ChatRoomViewModel {
  ChatRoomViewModel({
    required this.chatRoomRepository,
  });

  final ChatRemoteDataSource chatRoomRepository;

  /// 채팅 메시지 스트림
  Stream<List<ChatMessageModel>> chatMessagesStream(String chatId) {
    return chatRoomRepository.chatMessagesStream(chatId);
  }

  /// 메시지 정렬
  Future<void> fetchMessageOrder(String chatId) =>
      chatRoomRepository.fetchMessageOrder(chatId);

  /// 메시지 업로드
  Future<void> uploadChatMessage(String chatId, String localAudioUrl,
      String dateCreated, String userEmail) async {
    await chatRoomRepository.uploadChatMessageWithAudio(
      chatId: chatId,
      localAudioUrl: localAudioUrl,
      dateCreated: dateCreated,
      userEmail: userEmail,
    );
  }

  /// 메시지 삭제
  Future<void> deleteChatRoom(Map<String, dynamic> chatData) async {
    await chatRoomRepository.deleteChatRoom(chatData);
  }
}
