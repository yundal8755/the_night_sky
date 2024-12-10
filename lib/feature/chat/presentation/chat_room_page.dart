// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/feature/chat/domain/chat_message_model.dart';
import 'package:everyones_tone/app/repository/firestore_data.dart';
import 'package:everyones_tone/app/utils/audio_play_provider.dart';
import 'package:everyones_tone/app/utils/record_status_manager.dart';
import 'package:everyones_tone/feature/chat/presentation/chat_room_view_model.dart';
import 'package:everyones_tone/presentation/widgets/app_bar/chat_room_sliver_app_bar.dart';
import 'package:everyones_tone/presentation/widgets/record_buttons/record_status_button.dart';
import 'package:everyones_tone/presentation/widgets/layout/main_background_layout.dart';
import 'package:everyones_tone/presentation/widgets/tiles/partner_user_message_tile.dart';
import 'package:everyones_tone/presentation/widgets/tiles/current_user_message_tile.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatRoomPage extends StatelessWidget {
  final Map<String, dynamic> chatData;

  /// GetIt을 통해 인스턴스 가져오기
  final chatRoomViewModel = GetIt.I<ChatRoomViewModel>();

  ChatRoomPage({super.key, required this.chatData});

  @override
  Widget build(BuildContext context) {
    // 계속해서 변하는 객체이므로 get it 사용하면 안됨
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
        backgroundColor: Colors.transparent,
        body: MainBackgroundLayout(
          child: StreamBuilder<List<ChatMessageModel>>(
            stream: chatRoomViewModel.chatMessagesStream(chatData['chatId']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: AppColor.primaryBlue,
                ));
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No messages available'));
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
                              var currentUserEmail =
                                  FirestoreData.currentUserEmail;
                              var postUserEmail = chatData['postUserEmail'];
                              var replyUserEmail = chatData['replyUserEmail'];

                              //! Case 1: 현재 사용자가 게시물 작성자이고, 메시지가 현재 사용자인 경우
                              if (currentUserEmail ==
                                      chatMessageInfo.userEmail &&
                                  currentUserEmail == postUserEmail) {
                                return CurrentUserMessageTile(
                                  dateCreated: chatMessageInfo.dateCreated,
                                  backgroundImage:
                                      chatData['postUserProfilePicUrl'],
                                  nickname: chatData['postUserNickname'],
                                  audioUrl: chatMessageInfo.audioUrl,
                                );
                              }
                              //! Case 2: 현재 사용자가 답변 작성자이고, 메시지가 현재 사용자인 경우
                              else if (currentUserEmail ==
                                      chatMessageInfo.userEmail &&
                                  currentUserEmail == replyUserEmail) {
                                return CurrentUserMessageTile(
                                  dateCreated: chatMessageInfo.dateCreated,
                                  backgroundImage:
                                      chatData['replyUserProfilePicUrl'],
                                  nickname: chatData['replyUserNickname'],
                                  audioUrl: chatMessageInfo.audioUrl,
                                );
                              }
                              //! Case 3: 현재 사용자가 게시물 작성자이지만, 메시지가 답변 작성자인 경우
                              else if (currentUserEmail !=
                                      chatMessageInfo.userEmail &&
                                  currentUserEmail == postUserEmail) {
                                return PartnerUserMessageTile(
                                  dateCreated: chatMessageInfo.dateCreated,
                                  profilePicUrl:
                                      chatData['replyUserProfilePicUrl'],
                                  nickname: chatData['replyUserNickname'],
                                  audioUrl: chatMessageInfo.audioUrl,
                                );
                              }
                              //! Case 4: 메시지가 상대방 사용자로부터 온 경우
                              else {
                                return PartnerUserMessageTile(
                                  dateCreated: chatMessageInfo.dateCreated,
                                  profilePicUrl:
                                      chatData['postUserProfilePicUrl'],
                                  nickname: chatData['postUserNickname'],
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
                                    barrierColor:
                                        AppColor.neutrals90.withOpacity(0.95),
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
      ),
    );
  }
}
