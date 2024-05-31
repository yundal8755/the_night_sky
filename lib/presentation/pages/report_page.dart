import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/presentation/pages/bottom_nav_bar_page.dart';
import 'package:everyones_tone/presentation/widgets/custom_buttons/main_button.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
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

                //! 페이지 닫기 버튼
                MainButton(
                    backgroundColor: AppColor.primaryBlue,
                    text: '페이지 닫기',
                    textColor: AppColor.neutrals20,
                    onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => BottomNavBarPage())))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
