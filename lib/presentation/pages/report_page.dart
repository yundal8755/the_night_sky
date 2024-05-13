import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
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
                  padding: const EdgeInsets.symmetric(vertical: 36),
                  height: MediaQuery.of(context).size.height / 4.25,
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
                      Text('신고 되었어요', style: AppTextStyle.headlineMedium()),
                      const Text('신고된 내용은 검토 후 조치할 예정이에요.')
                    ],
                  ),
                ),
        
                //! 페이지 닫기 버튼
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColor.primaryBlue),
                      child: Center(
                          child: Text(
                        '페이지 닫기',
                        style: AppTextStyle.bodyLarge(),
                      ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
