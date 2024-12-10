import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:everyones_tone/feature/chat/presentation/chat_list_view_model.dart';
import 'package:everyones_tone/presentation/widgets/tiles/chat_thumbnail_tile.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatListViewModel()..loadChatList(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            '채팅방',
            style: AppTextStyle.headlineMedium(),
          ),
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
        body: Consumer<ChatListViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.chatList.isEmpty) {
              return const Center(child: Text('채팅방이 없습니다.'));
            }

            return ListView.builder(
              itemCount: viewModel.chatList.length,
              itemBuilder: (context, index) {
                var chat = viewModel.chatList[index];
                return ChatThumbnailTile(
                  chatData: chat.toMap(),
                  nickname: chat.postUserNickname,
                  profilePicUrl: chat.postUserProfilePicUrl,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
