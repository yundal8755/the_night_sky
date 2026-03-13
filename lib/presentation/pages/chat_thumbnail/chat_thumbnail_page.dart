// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, avoid_print, must_be_immutable

import 'package:everyones_tone/app/style/app_color.dart';
import 'package:everyones_tone/app/style/app_gap.dart';
import 'package:everyones_tone/app/util/bottom_sheet.dart';
import 'package:everyones_tone/app/service/firebase_service.dart';
import 'package:everyones_tone/presentation/pages/chat_thumbnail/chat_thumbnail_view_model.dart';
import 'package:everyones_tone/presentation/pages/login/initial_login_page.dart';
import 'package:everyones_tone/presentation/widgets/app_bar/main_app_bar.dart';
import 'package:everyones_tone/presentation/widgets/tiles/chat_thumbnail_tile.dart';
import 'package:flutter/material.dart';

class ChatThumbnailPage extends StatelessWidget {
  ChatThumbnailPage({super.key});

  @override
  Widget build(BuildContext context) {
    ChatThumbnailViewModel chatThumbnailViewModel = ChatThumbnailViewModel();

    if (FirebaseService.currentUser == null) {
      bottomSheet(
          context: context,
          child: InitialLoginPage(),
          bottomSheetType: BottomSheetHeight.postPage);
    }

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Column(
          children: [
            MainAppBar(title: '채팅방'),
            Gap.size08,
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: chatThumbnailViewModel.fetchChatInfoStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: AppColor.primaryBlue,
                    ));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                        child: Text('채팅방이 없습니다.',
                            style: TextStyle(color: AppColor.neutrals20)));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var chatData = snapshot.data![index];
                      return ChatThumbnailTile(
                        chatData: chatData,
                        nickname: FirebaseService.currentUserEmail ==
                                chatData['postUserEmail']
                            ? chatData['replyUserNickname']
                            : chatData['postUserNickname'],
                        profilePicUrl: FirebaseService.currentUserEmail ==
                                chatData['postUserEmail']
                            ? chatData['replyUserProfilePicUrl']
                            : chatData['postUserProfilePicUrl'],
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
