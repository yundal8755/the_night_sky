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
        width: MediaQuery.of(context).size.width / 6,
        height: MediaQuery.of(context).size.height / 5.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //! 안내 문구
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(title, style: AppTextStyle.bodyLarge()),
                Gap.size4,
                Text(
                  message,
                  style: AppTextStyle.bodyMedium(AppColor.neutrals20),
                ),
              ],
            ),

            //! 버튼
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: onConfirm,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.primaryBlue,
                    ),
                    child: Center(
                      child: Text(
                        mainButtonTitle,
                        style: AppTextStyle.bodyMedium(),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        '닫기',
                        style: AppTextStyle.bodyMedium(),
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
    context: context,
    builder: (BuildContext context) => CustomDialog(
      title: '로그아웃',
      message: '로그아웃 하시겠습니까?',
      onConfirm: () {},
      mainButtonTitle: '로그아웃',
    ),
  );
}
