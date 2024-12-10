import 'package:everyones_tone/feature/chat/domain/chat_model.dart';
import 'package:everyones_tone/feature/chat/data/chat_list_datasource.dart';

class ChatListRepository {
  final ChatListDataSource _dataSource = ChatListDataSource();

  Future<List<ChatModel>> fetchChatList() async {
    try {
      // DataSource에서 JSON 형태의 데이터 리스트 가져오기
      List<Map<String, dynamic>> chatDataList =
          await _dataSource.fetchChatData();

      // JSON 데이터를 ChatModel 리스트로 변환
      List<ChatModel> chatList =
          chatDataList.map((data) => ChatModel.fromMap(data)).toList();
      return chatList;
    } catch (e) {
      return [];
    }
  }
}
