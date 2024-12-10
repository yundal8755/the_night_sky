import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/repository/firestore_data.dart';

class ChatListDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchChatData() async {
    List<Map<String, dynamic>> chatDataList = [];

    var userDocSnapshot = await _firestore
        .collection(FirestoreData.userCollection)
        .doc(FirestoreData.currentUserEmail)
        .get();
    if (!userDocSnapshot.exists) {
      return [];
    }

    List<dynamic> myChatList = userDocSnapshot.data()?['myChatList'] ?? [];

    // myChatList의 각 chatId를 기반으로 chat 컬렉션에서 데이터 가져오기
    for (String chatId in myChatList) {
      var chatDocSnapshot =
          await _firestore.collection('chat').doc(chatId).get();
      if (chatDocSnapshot.exists) {
        var chatData = chatDocSnapshot.data()!;
        chatData['chatId'] = chatId;
        chatDataList.add(chatData);
      }
    }

    return chatDataList;
  }
}
