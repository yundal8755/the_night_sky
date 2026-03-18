// ignore_for_file: avoid_print

import 'package:everyones_tone/app/di/service_locator.dart';
import 'package:everyones_tone/data/remote_datasource/chat_remote_data_source.dart';

class ChatThumbnailViewModel {
  ChatThumbnailViewModel({
    ChatRemoteDataSource? chatRemoteDataSource,
  }) : chatRemoteDataSource =
            chatRemoteDataSource ?? getIt<ChatRemoteDataSource>();

  final ChatRemoteDataSource chatRemoteDataSource;

  Stream<List<Map<String, dynamic>>> fetchChatInfoStream() async* {
    yield* chatRemoteDataSource.fetchChatInfoStream();
  }

  Future<int> fetchMessageCount(String chatId) async {
    return chatRemoteDataSource.fetchMessageCount(chatId);
  }
}
