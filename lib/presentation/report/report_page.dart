import 'package:everyones_tone/app/style/app_color.dart';
import 'package:everyones_tone/app/style/app_gap.dart';
import 'package:everyones_tone/app/style/app_text_style.dart';
import 'package:everyones_tone/app/router/app_router.dart';
import 'package:everyones_tone/presentation/report/report_view_model.dart';
import 'package:everyones_tone/presentation/common/widget/custom_buttons/main_button.dart';
import 'package:everyones_tone/presentation/common/widget/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatelessWidget {
  final String currentDocumentId;
  final String postUserEmail;

  const ReportPage(
      {super.key,
      required this.currentDocumentId,
      required this.postUserEmail});

  @override
  Widget build(BuildContext context) {
    final reportViewModel =
        Provider.of<ReportViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColor.neutrals90,
      body: PopScope(
        canPop: false,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //! 안내 문구
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 36),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CircleAvatar(
                        backgroundColor: AppColor.secondaryGreen,
                        child: Icon(
                          Icons.check,
                          color: AppColor.neutrals20,
                        ),
                      ),
                      Gap.size08,
                      Text('신고 되었어요', style: AppTextStyle.headlineMedium()),
                      Gap.size04,
                      const Text('신고된 내용은 검토 후 조치할 예정이에요.',
                          style: TextStyle(color: AppColor.neutrals40))
                    ],
                  ),
                ),

                Column(
                  children: [
                    //! 페이지 닫기 버튼
                    MainButton(
                      backgroundColor: AppColor.primaryBlue,
                      text: '페이지 닫기',
                      textColor: AppColor.neutrals20,
                      onPressed: () => context.go(AppRouteLocation.home),
                    ),

                    //! 페이지 닫기 버튼
                    MainButton(
                        backgroundColor: AppColor.neutrals90,
                        borderSideColor: AppColor.primaryBlue,
                        text: '사용자 차단하기',
                        textColor: AppColor.neutrals20,
                        onPressed: () {
                          DialogWidget.showTwoOptionDialog(
                            context: context,
                            title: '해당 사용자를 차단하시겠습니까?',
                            message: '차단한 사용자의 모든 게시글은\n더 이상 볼 수 없습니다.',
                            onTap: () async {
                              await reportViewModel.blockUsers(
                                  blockedUserEmail: postUserEmail);

                              context.go(AppRouteLocation.home);
                            },
                          );
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
