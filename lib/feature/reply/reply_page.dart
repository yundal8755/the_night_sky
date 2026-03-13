// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:everyones_tone/app/style/app_color.dart';
import 'package:everyones_tone/app/style/app_gap.dart';
import 'package:everyones_tone/app/constant/app_assets.dart';
import 'package:everyones_tone/app/service/firebase_service.dart';
import 'package:everyones_tone/common/widget/anonymousProfileSwitch.dart';
import 'package:everyones_tone/feature/reply/reply_view_model.dart';
import 'package:everyones_tone/app/util/record_status_manager.dart';
import 'package:everyones_tone/common/widget/app_bar/sub_app_bar.dart';
import 'package:everyones_tone/common/widget/record_buttons/record_status_button.dart';
import 'package:everyones_tone/common/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReplyPage extends StatelessWidget {
  final String replyDocmentId;

  const ReplyPage({super.key, required this.replyDocmentId});

  @override
  Widget build(BuildContext context) {
    final ReplyViewModel replyViewModel = ReplyViewModel();
    final recordStatusManager =
        Provider.of<RecordStatusManager>(context, listen: false);

    String currentNickname = '';
    String currentProfilePicUrl = AppAssets.profileBasicImage;

    print('Reply CurrentDocumentId : $replyDocmentId');

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SubAppBar(
                title: '메시지 보내기',
                onPressed: () async {
                  //! Progress Indicator
                  showDialog(
                    barrierColor: AppColor.neutrals90.withOpacity(0.5),
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

                  // ! 업로드에 필요한 포스팅 정보 확보하기
                  // 오디오 URL
                  String localAudioUrl = recordStatusManager.audioFilePath!;

                  // Firestore에 저장된 User의 Data
                  final replyUserData =
                      await FirebaseService.fetchCurrentUser();
                  if (replyUserData == null) {
                    return;
                  }

                  final replyUser = UserModel(
                    userEmail: replyUserData.userEmail,
                    dateCreated: replyUserData.dateCreated,
                    nickname: currentNickname.isNotEmpty
                        ? currentNickname
                        : replyUserData.nickname,
                    profilePicUrl: currentProfilePicUrl.isNotEmpty
                        ? currentProfilePicUrl
                        : replyUserData.profilePicUrl,
                  );

                  await replyViewModel.uploadReply(
                      localAudioUrl: localAudioUrl,
                      replyUser: replyUser,
                      replyDocumentId: replyDocmentId);

                  recordStatusManager.resetToBefore();

                  //! Route
                  Navigator.pop(context); // 다이얼로그 닫기
                  Navigator.pop(context); // Home으로 이동
                },
              ),
              Gap.size06,
              AnonymousProfileSwitch(
                  onProfileChanged: (nickname, profilePicUrl) {
                currentNickname = nickname;
                currentProfilePicUrl = profilePicUrl;
              })
            ],
          ),
          RecordStatusButton()
        ],
      ),
    );
  }
}
