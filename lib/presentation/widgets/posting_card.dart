// ignore_for_file: use_build_context_synchronously

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/app/repository/firestore_data.dart';
import 'package:everyones_tone/app/utils/audio_play_provider.dart';
import 'package:everyones_tone/app/utils/bottom_sheet.dart';
import 'package:everyones_tone/presentation/pages/login/initial_login_page.dart';
import 'package:everyones_tone/presentation/pages/reply/reply_page.dart';
import 'package:everyones_tone/presentation/pages/report/report_page.dart';
import 'package:everyones_tone/presentation/pages/report/report_view_model.dart';
import 'package:everyones_tone/presentation/widgets/custom_buttons/play_icon_button.dart';
import 'package:everyones_tone/presentation/widgets/custom_buttons/main_button.dart';
import 'package:everyones_tone/presentation/widgets/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class PostingCard extends StatelessWidget {
  final String profilePicUrl;
  final String audioUrl;
  final String postTitle;
  final String nickname;
  final String currentDocumentId;
  final String postUserEmail;

  const PostingCard(
      {super.key,
      required this.profilePicUrl,
      required this.audioUrl,
      required this.nickname,
      required this.postTitle,
      required this.currentDocumentId,
      required this.postUserEmail});

  @override
  Widget build(BuildContext context) {
    const double circularInt = 40;
    double cardWidth = MediaQuery.of(context).size.width / 1.2;
    double cardHeight = cardWidth * 1.45;

    final ReportViewModel reportViewModel = ReportViewModel();

    return Center(
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(circularInt),
          color: AppColor.neutrals20,
          boxShadow: [
            BoxShadow(
              color: AppColor.neutrals80.withOpacity(0.3), // 그림자의 색상
              spreadRadius: 8, // 그림자의 확장 범위
              blurRadius: 40, // 그림자의 흐림 정도
              offset: const Offset(0, 0), // 그림자의 위치
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(circularInt),
                  image: DecorationImage(
                      image: AssetImage(profilePicUrl), fit: BoxFit.fill)),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(circularInt),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topCenter,
                  stops: const [0.2, 0.35, 1], // 중간 지점을 추가하여 그라데이션 전환을 조절
                  colors: [
                    AppColor.neutrals90.withOpacity(0.7), // 아래쪽은 더 진한 검정색
                    AppColor.neutrals90.withOpacity(0.5), // 중간은 보다 투명
                    Colors.transparent
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // DummyData
                  Gap.size10,

                  Column(
                    children: [
                      // player, 게시글 정보
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Column(
                          children: [
                            // 게시글 정보
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(postTitle,
                                    style: AppTextStyle.headlineLarge()),
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

                      // 재생, 답장, 신고 버튼
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 재생 버튼
                            PlayIconButton(audioUrl: audioUrl),

                            // 답장, 신고 버튼
                            Row(
                              children: [
                                // 답장 버튼
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    onPressed: () async {
                                      Provider.of<AudioPlayProvider>(context,
                                              listen: false)
                                          .stopPlaying();

                                      if (FirestoreData.currentUser == null) {
                                        bottomSheet(
                                            context: context,
                                            child: InitialLoginPage(),
                                            bottomSheetType:
                                                BottomSheetHeight.loginPage);
                                      } else if (postUserEmail ==
                                          FirestoreData.currentUserEmail) {
                                        DialogWidget.showSingleOptionDialog(
                                            context, '자신에게는 메시지를 보낼 수 없습니다.');
                                      } else {
                                        bool hasReplied = await FirestoreData
                                            .hasRepliedBefore(
                                                FirestoreData.currentUserEmail!,
                                                currentDocumentId);
                                        if (hasReplied) {
                                          DialogWidget.showSingleOptionDialog(
                                              context, '이미 답장을 보냈던 게시글입니다.');
                                        } else {
                                          bottomSheet(
                                            context: context,
                                            child: ReplyPage(
                                                replyDocmentId:
                                                    currentDocumentId),
                                            bottomSheetType:
                                                BottomSheetHeight.replyPage,
                                          );
                                        }
                                      }
                                    },
                                    icon: SvgPicture.asset(
                                        AppAssets.messageDefault32),
                                  ),
                                ),

                                // 신고 버튼
                                IconButton(
                                  onPressed: () {
                                    Provider.of<AudioPlayProvider>(context,
                                            listen: false)
                                        .stopPlaying();
                                    FirestoreData.currentUser == null
                                        ? bottomSheet(
                                            context: context,
                                            child: InitialLoginPage(),
                                            bottomSheetType:
                                                BottomSheetHeight.loginPage)
                                        : bottomSheet(
                                            context: context,
                                            child: SafeArea(
                                              child: SingleChildScrollView(
                                                child: MainButton(
                                                  backgroundColor:
                                                      AppColor.neutrals90,
                                                  text: '신고하기',
                                                  textColor:
                                                      AppColor.secondaryRed,
                                                  onPressed: () {
                                                    Navigator.of(context).pop();

                                                    DialogWidget
                                                        .showTwoOptionDialog(
                                                      context: context,
                                                      title:
                                                          '해당 게시글을 신고하시겠습니까?',
                                                      message:
                                                          '신고한 게시물은 더 이상 볼 수 없습니다.',
                                                      onTap: () async {
                                                        await reportViewModel
                                                            .reportPosts(
                                                                reportedChatId:
                                                                    currentDocumentId);

                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    ReportPage(
                                                              currentDocumentId:
                                                                  currentDocumentId,
                                                              postUserEmail:
                                                                  postUserEmail,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            bottomSheetType: BottomSheetHeight
                                                .dialogBoxOneButton,
                                          );
                                  },
                                  icon: const Icon(
                                    Icons.more_vert_rounded,
                                    size: 32,
                                    color: AppColor.neutrals40,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
