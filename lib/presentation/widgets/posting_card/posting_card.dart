import 'dart:ui';

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/app/repository/firestore_data.dart';
import 'package:everyones_tone/app/utils/bottom_sheet.dart';
import 'package:everyones_tone/presentation/pages/reply/reply_page.dart';
import 'package:everyones_tone/presentation/pages/report_page.dart';
import 'package:everyones_tone/presentation/widgets/audio_player/ractangel_audio_player.dart';
import 'package:everyones_tone/presentation/widgets/dialog/warning_dialog.dart';
import 'package:everyones_tone/presentation/widgets/audio_player/circle_audio_player.dart';
import 'package:everyones_tone/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:everyones_tone/presentation/widgets/dialog/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BasicRoundPostingCard extends StatelessWidget {
  final String profilePicUrl;
  final String audioUrl;
  final String postTitle;
  final String nickname;
  final String replyDocmentId;
  final String postUserEmail;

  const BasicRoundPostingCard(
      {super.key,
      required this.profilePicUrl,
      required this.audioUrl,
      required this.nickname,
      required this.postTitle,
      required this.replyDocmentId,
      required this.postUserEmail});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // width: MediaQuery.of(context).size.width / 1.2,
        // height: MediaQuery.of(context).size.height / 1.75,
        // padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        // decoration: BoxDecoration(
        //   color: AppColor.neutrals80,
        //   borderRadius: BorderRadius.circular(30),
        // ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 1.75,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                color: AppColor.neutrals40.withOpacity(0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // player, 게시글 정보
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 6),
                      child: Column(
                        children: [
                          // 음성 재생 버튼
                          CircleAudioPlayer(
                            audioUrl: audioUrl,
                            backgroundImage: profilePicUrl,
                            pauseIconSize: AppAssets.pauseDefault56,
                            playIconSize: AppAssets.playDefault56,
                            radius: MediaQuery.of(context).size.width / 2.75,
                          ),

                          Gap.size20,
                          // 게시글 정보
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                '모두의 음색',
                                style: AppTextStyle.labelMedium(
                                    AppColor.primaryBlue),
                              ),
                              Text(
                                postTitle,
                                style: AppTextStyle.headlineLarge(),
                              ),
                              Text(
                                nickname,
                                style: AppTextStyle.bodyLarge(
                                    AppColor.neutrals40),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // 답장 버튼
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              postUserEmail == FirestoreData.currentUserEmail
                                  ? showDialog(
                                      barrierColor:
                                          AppColor.neutrals90.withOpacity(0.95),
                                      context: context,
                                      builder: (context) => const WarningDialog(
                                          text: '자신에게는 메시지를 보낼 수 없습니다.'))
                                  : bottomSheet(
                                      context: context,
                                      child: ReplyPage(
                                          replyDocmentId: replyDocmentId),
                                      bottomSheetType:
                                          BottomSheetType.replyPage,
                                    );
                            },
                            icon: SvgPicture.asset(AppAssets.messageDefault32),
                          ),
                          IconButton(
                            onPressed: () {
                              bottomSheet(
                                context: context,
                                child: SafeArea(
                                  child: CustomElevatedButton(
                                    backgroundColor: AppColor.neutrals90,
                                    text: '신고',
                                    textColor: AppColor.secondaryRed,
                                    onPressed: () {
                                      Navigator.of(context).pop();

                                      showDialog(
                                        barrierColor: AppColor.neutrals90
                                            .withOpacity(0.95),
                                        context: context,
                                        builder: (BuildContext context) =>
                                            CustomDialog(
                                          title: '신고하기',
                                          message: '해당 이용자를 신고하시겠습니까?',
                                          mainButtonTitle: '신고하기',
                                          onConfirm: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ReportPage()));
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                bottomSheetType:
                                    BottomSheetType.dialogBoxOneButton,
                              );
                            },
                            icon: const Icon(
                              Icons.more_vert_rounded,
                              size: 32,
                              color: AppColor.neutrals40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
