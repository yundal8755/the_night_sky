// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/models/chat_message_model.dart';
import 'package:everyones_tone/app/repository/firestore_data.dart';
import 'package:everyones_tone/app/utils/audio_play_provider.dart';
import 'package:everyones_tone/app/utils/record_status_manager.dart';
import 'package:everyones_tone/presentation/pages/chat_room/chat_room_view_model.dart';
import 'package:everyones_tone/presentation/widgets/app_bar/chat_room_sliver_app_bar.dart';
import 'package:everyones_tone/presentation/widgets/buttons/record_buttons/record_status_button.dart';
import 'package:everyones_tone/presentation/widgets/list_tile/partner_user_message_tile.dart';
import 'package:everyones_tone/presentation/widgets/list_tile/current_user_message_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatRoomPage extends StatelessWidget {
  final Map<String, dynamic> chatData;

  const ChatRoomPage({super.key, required this.chatData});

  @override
  Widget build(BuildContext context) {
    ChatRoomViewModel chatRoomViewModel = ChatRoomViewModel();
    final recordStatusManager =
        Provider.of<RecordStatusManager>(context, listen: false);
    chatRoomViewModel.fetchMessageOrder(chatData['chatId']);

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        // 음성 재생 중이라면 정지
        if (Provider.of<AudioPlayProvider>(context, listen: false).isPlaying) {
          Provider.of<AudioPlayProvider>(context, listen: false).stopPlaying();
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.neutrals90,
        body: StreamBuilder<List<ChatMessageModel>>(
          stream: chatRoomViewModel.chatMessagesStream(chatData['chatId']),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Stack(
                children: [
                  CustomScrollView(
                    slivers: <Widget>[
                      ChatRoomSliverAppBar(
                          audioUrl: snapshot.data!.last.audioUrl,
                          chatData: chatData,
                          postUserNickname: chatData['postUserNickname'],
                          postUserProfilePicUrl:
                              chatData['postUserProfilePicUrl']),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            var chatMessageInfo = snapshot.data![index];
                            if (FirestoreData.currentUserEmail ==
                                chatMessageInfo.userEmail) {
                              return CurrentUserMessageTile(
                                dateCreated: chatMessageInfo.dateCreated,
                                backgroundImage:
                                    chatData['currentUserProfilePicUrl'],
                                nickname: chatData['currentUserNickname'],
                                audioUrl: chatMessageInfo.audioUrl,
                              );
                            } else {
                              return PartnerUserMessageTile(
                                dateCreated: chatMessageInfo.dateCreated,
                                backgroundImage:
                                    chatData['partnerUserProfilePicUrl'],
                                nickname: chatData['partnerUserNickname'],
                                audioUrl: chatMessageInfo.audioUrl,
                              );
                            }
                          },
                          childCount: snapshot.data?.length ?? 0,
                        ),
                      )
                    ],
                  ),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 112,
                        child: Consumer<RecordStatusManager>(
                          builder: (context, value, child) {
                            var messages = snapshot.data ?? [];
                            bool isLastMessageMine = messages.isNotEmpty &&
                                messages.first.userEmail ==
                                    FirestoreData.currentUserEmail;

                            return RecordStatusButton(
                              isLastMessageMine: isLastMessageMine,
                              isChatRoomPage: true,
                              onPressed: () {
                                //! Progress Indicator
                                showDialog(
                                  barrierColor: AppColor.neutrals90.withOpacity(0.95),
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return const Center(
                                      child: SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator(
                                            color: AppColor.primaryBlue,
                                          )),
                                    );
                                  },
                                );

                                String chatId = chatData['chatId'];
                                String localAudioUrl =
                                    recordStatusManager.audioFilePath!;
                                String dateCreated =
                                    DateFormat("MM/dd HH:mm:ss")
                                        .format(DateTime.now());
                                String userEmail =
                                    FirestoreData.currentUserEmail!;

                                chatRoomViewModel
                                    .uploadChatMessage(chatId, localAudioUrl,
                                        dateCreated, userEmail)
                                    .then(
                                  (_) {
                                    // 메시지 업로드 후 RecordStatus 리셋
                                    recordStatusManager.resetToBefore();
                                  },
                                );
                                Navigator.pop(context); // 다이얼로그 닫기
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
