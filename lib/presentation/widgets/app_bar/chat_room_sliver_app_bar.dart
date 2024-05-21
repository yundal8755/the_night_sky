import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/app/repository/firestore_data.dart';
import 'package:everyones_tone/app/utils/audio_play_provider.dart';
import 'package:everyones_tone/app/utils/bottom_sheet.dart';
import 'package:everyones_tone/presentation/widgets/dialog/chat_room_dialog_box.dart';
import 'package:everyones_tone/presentation/widgets/audio_player/ractangel_audio_player.dart';
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
    return SliverAppBar(
      backgroundColor: AppColor.neutrals90,
      leading: const BackButton(color: AppColor.neutrals20),
      actions: [
        IconButton(
            onPressed: () {
              Provider.of<AudioPlayProvider>(context, listen: false).stopPlaying();
              bottomSheet(
                  context: context,
                  child: ChatRoomDialogBox(chatData:  chatData),
                  bottomSheetType: BottomSheetType.dialogBoxTwoButton);
            },
            icon: const Icon(
              Icons.more_vert,
              color: AppColor.neutrals20,
            )),
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
                    FirestoreData.currentUserEmail ==
                            chatData['currentUserEmail']
                        ? chatData['partnerUserNickname']
                        : chatData['currentUserNickname'],
                    style: AppTextStyle.headlineMedium(),
                  )
                : null,
            background: SafeArea(
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
          );
        },
      ),
    );
  }
}
