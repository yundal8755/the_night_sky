import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/app/repository/firestore_data.dart';
import 'package:everyones_tone/app/utils/audio_play_provider.dart';
import 'package:everyones_tone/app/utils/bottom_sheet.dart';
import 'package:everyones_tone/presentation/pages/bottom_nav_bar_page.dart';
import 'package:everyones_tone/feature/chat/presentation/chat_room_view_model.dart';
import 'package:everyones_tone/presentation/pages/report/report_view_model.dart';
import 'package:everyones_tone/presentation/widgets/custom_buttons/main_button.dart';
import 'package:everyones_tone/presentation/widgets/audio_player/ractangel_audio_player.dart';
import 'package:everyones_tone/presentation/widgets/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatRoomSliverAppBar extends StatelessWidget {
  final String audioUrl;
  final Map<String, dynamic> chatData;
  final String postUserNickname;
  final String postUserProfilePicUrl;

  const ChatRoomSliverAppBar({
    super.key,
    required this.audioUrl,
    required this.chatData,
    required this.postUserNickname,
    required this.postUserProfilePicUrl,
  });

  @override
  Widget build(BuildContext context) {
    final ChatRoomViewModel chatRoomViewModel = ChatRoomViewModel();
    final ReportViewModel reportViewModel = ReportViewModel();
    final postUserEmail = chatData['postUserEmail'];

    return SliverAppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      leading: const BackButton(color: AppColor.neutrals20),
      actions: [
        IconButton(
          onPressed: () {
            Provider.of<AudioPlayProvider>(context, listen: false)
                .stopPlaying();
            bottomSheet(
                context: context,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        MainButton(
                          backgroundColor: AppColor.neutrals90,
                          text: '채팅방 나가기',
                          textColor: AppColor.neutrals20,
                          onPressed: () async {
                            Navigator.of(context).pop();

                            DialogWidget.showTwoOptionDialog(
                              context: context,
                              title: '채팅방을 나가시겠습니까?',
                              message: '주고 받은 대화들은 모두 삭제됩니다.',
                              onTap: () async {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (_) => BottomNavBarPage(),
                                  ),
                                );
                                await chatRoomViewModel
                                    .deleteChatRoom(chatData);
                              },
                            );
                          },
                        ),
                        MainButton(
                          backgroundColor: AppColor.neutrals90,
                          text: '신고하기',
                          textColor: AppColor.secondaryRed,
                          onPressed: () {
                            Navigator.of(context).pop();

                            DialogWidget.showTwoOptionDialog(
                              context: context,
                              title: '사용자를 신고하시겠습니까?',
                              message:
                                  '신고시 채팅방은 삭제 처리되며, 해당 사용자의 게시글 노출이 제한됩니다.',
                              onTap: () async {
                                // 게시글 노출 제한
                                var blockedUserEmail = '';

                                if (FirestoreData.currentUserEmail ==
                                    postUserEmail) {
                                  blockedUserEmail = chatData['replyUserEmail'];
                                } else {
                                  blockedUserEmail = chatData['postUserEmail'];
                                }

                                await reportViewModel.blockUsers(
                                    blockedUserEmail: blockedUserEmail);

                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (_) => BottomNavBarPage(),
                                  ),
                                );

                                // 채팅방 삭제 처리
                                await chatRoomViewModel
                                    .deleteChatRoom(chatData);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                bottomSheetType: BottomSheetHeight.dialogBoxTwoButton);
          },
          icon: const Icon(
            Icons.more_vert,
            color: AppColor.neutrals20,
          ),
        ),
      ],
      pinned: true,
      floating: false,
      expandedHeight: MediaQuery.of(context).size.height / 2.5,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var top = constraints.biggest.height;

          return FlexibleSpaceBar(
            centerTitle: true,
            titlePadding: const EdgeInsets.only(bottom: 16.0),
            title: top == MediaQuery.of(context).padding.top + kToolbarHeight
                ? Text(
                    FirestoreData.currentUserEmail == postUserEmail
                        ? chatData['replyUserNickname']
                        : chatData['postUserNickname'],
                    style: AppTextStyle.headlineMedium(),
                  )
                : null,
            background: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 56, bottom: 16),
                        child: RectangleAudioPlayer(
                          audioUrl: audioUrl,
                          backgroundImage: postUserProfilePicUrl,
                          pauseIconSize: AppAssets.pauseDefault56,
                          playIconSize: AppAssets.playDefault56,
                          widthSize: MediaQuery.of(context).size.width / 2.25,
                          heightSize: MediaQuery.of(context).size.width / 2.25,
                          opacity: 0.75,
                        )),
                    Text(
                      chatData['postTitle'],
                      style: AppTextStyle.headlineMedium(),
                    ),
                    Gap.size04,
                    Text(
                      postUserNickname,
                      style: AppTextStyle.bodyLarge(AppColor.neutrals40),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
