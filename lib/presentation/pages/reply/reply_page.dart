// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/app/repository/firestore_data.dart';
import 'package:everyones_tone/presentation/widgets/anonymousProfileSwitch.dart';
import 'package:everyones_tone/presentation/pages/reply/reply_view_model.dart';
import 'package:everyones_tone/app/utils/record_status_manager.dart';
import 'package:everyones_tone/presentation/widgets/app_bar/sub_app_bar.dart';
import 'package:everyones_tone/presentation/widgets/record_buttons/record_status_button.dart';
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
                  Map<String, dynamic>? replyUserData =
                      await FirestoreData.fetchUserData();

                  replyUserData!['nickname'] = currentNickname;
                  replyUserData['profilePicUrl'] = currentProfilePicUrl;

                  await replyViewModel.uploadReply(
                      localAudioUrl: localAudioUrl,
                      replyUserData: replyUserData,
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
