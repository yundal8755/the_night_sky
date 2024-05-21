import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:flutter/material.dart';

class WarningDialog extends StatelessWidget {
  final String text;

  const WarningDialog({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(12),
      backgroundColor: AppColor.neutrals80,
      content: Container(
        width: MediaQuery.of(context).size.width / 1.25,
        height: 160,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //! 안내 문구
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.warning_rounded,
                    color: AppColor.neutrals60,
                    size: 48,
                  ),
                  Gap.size08,
                  Center(
                    child: Text(
                      text,
                      style: AppTextStyle.titleMedium(AppColor.neutrals20),
                    ),
                  )
                ],
              ),
            ),

            //! 버튼
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.neutrals60),
                child: Center(
                  child: Text(
                    '확인',
                    style: AppTextStyle.bodyLarge(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
