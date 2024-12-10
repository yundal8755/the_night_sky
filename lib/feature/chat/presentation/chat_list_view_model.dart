import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/repository/firestore_data.dart';
import 'package:everyones_tone/feature/chat/data/chat_list_repository.dart';
import 'package:flutter/material.dart';
import 'package:everyones_tone/app/models/chat_model.dart';

class ChatListViewModel extends ChangeNotifier {
  final ChatListRepository _repository = ChatListRepository();

  List<ChatModel> _chatList = [];
  List<ChatModel> get chatList => _chatList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// 채팅 데이터 불러오기
  Future<void> loadChatList() async {
    _isLoading = true;
    notifyListeners();

    _chatList = await _repository.fetchChatList();

    _isLoading = false;
    notifyListeners();
  }

  /// 채팅방 메시지 개수 불러오기
  Future<int> fetchMessageCount(String chatId) async {
    var messageCollection = FirebaseFirestore.instance
        .collection(FirestoreData.chatCollection)
        .doc(chatId)
        .collection(FirestoreData.messageSubCollection);
    var snapshot = await messageCollection.get();
    return snapshot.docs.length;
  }
}
