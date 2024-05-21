import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final String mainButtonTitle;
  final VoidCallback onConfirm;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.mainButtonTitle,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      backgroundColor: AppColor.neutrals80,
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        height: 140,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //! 안내 문구
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(title, style: AppTextStyle.titleLarge()),
                Gap.size04,
                Text(
                  message,
                  style: AppTextStyle.bodyLarge(AppColor.neutrals20),
                ),
              ],
            ),

            //! 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onConfirm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.primaryBlue,
                      ),
                      child: Center(
                        child: Text(
                          '확인',
                         // mainButtonTitle,
                          style: AppTextStyle.titleSmall(),
                        ),
                      ),
                    ),
                  ),
                ),
                Gap.size10,
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.neutrals60,
                      ),
                      child: Center(
                        child: Text(
                          '취소',
                          style: AppTextStyle.titleSmall(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showLogoutDialog(BuildContext context, VoidCallback onConfirm) {
  showDialog(
    barrierColor: AppColor.neutrals90.withOpacity(0.95),
    context: context,
    builder: (BuildContext context) => CustomDialog(
      title: '로그아웃',
      message: '로그아웃 하시겠습니까?',
      onConfirm: () {},
      mainButtonTitle: '로그아웃',
    ),
  );
}
