import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/models/chat_model.dart';
import 'package:everyones_tone/app/repository/firestore_data.dart';

class ChatViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final chatCollection = FirebaseFirestore.instance.collection('chat');

  Future<List<ChatModel>> fetchChatList() async {
    List<ChatModel> chatModels = [];  // ChatModel 객체를 저장할 리스트

    try {
      var myChatsQuerySnapshot = await _firestore
          .collection('user')
          .doc(FirestoreData.currentUserEmail)
          .collection('myChat')
          .get();

      for (var myChatDoc in myChatsQuerySnapshot.docs) {
        String chatId = myChatDoc.data()['chatId'];
        var chatQuerySnapshot = await chatCollection.doc(chatId).get();
        var chatModelData = chatQuerySnapshot.data();

        if (chatModelData != null) {
          ChatModel chatModel = ChatModel(
            chatId: chatId,
            postUserNickname: chatModelData['postUserNickname'],
            postUserEmail: chatModelData['postUserEmail'],
            postUserProfilePicUrl: chatModelData['postUserProfilePicUrl'],
            postTitle: chatModelData['postTitle'],
            replyUserNickname: chatModelData['replyUserNickname'],
            replyUserEmail: chatModelData['replyUserEmail'],
            replyUserProfilePicUrl: chatModelData['replyUserProfilePicUrl'],
            dateCreated: chatModelData['dateCreated']
          );
          chatModels.add(chatModel);
        }
      }
      return chatModels;
    } catch (e) {
      print("An error occurred while fetching chat list: $e");
      return [];
    }
  }
}
