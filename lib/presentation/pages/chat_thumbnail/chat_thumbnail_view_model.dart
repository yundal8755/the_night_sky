import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/repository/firestore_data.dart';

class ChatThumbnailViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final chatCollection = FirebaseFirestore.instance.collection('chat');

  Stream<List<Map<String, dynamic>>> fetchChatInfoStream() async* {
    await for (var snapshot in _firestore
        .collection('user')
        .doc(FirestoreData.currentUserEmail)
        .collection('myChat')
        .snapshots()) {
      List<Map<String, dynamic>> chatDataList = [];

      for (var myChatDoc in snapshot.docs) {
        var chatId = myChatDoc.id;
        try {
          var chatDocSnapshot = await chatCollection.doc(chatId).get();
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

  Future<int> fetchMessageCount(String chatId) async {
    var messageCollection = FirebaseFirestore.instance
        .collection('chat')
        .doc(chatId)
        .collection('message');
    var snapshot = await messageCollection.get();
    return snapshot.docs.length;
  }
}
