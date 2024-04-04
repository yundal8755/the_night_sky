import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:flutter/material.dart';

class SubAppBar extends StatelessWidget {
  const SubAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0),
        // 구분선
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColor.neutrals60,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 취소 버튼
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("취소",
                  style: AppTextStyle.bodyMedium(AppColor.neutrals60)),
            ),

            // 모달 제목
            Text(
              "음색 업로드",
              style: AppTextStyle.headlineMedium(),
            ),

            // 완료 버튼
            TextButton(
              onPressed: () {},
              child: Text(
                "완료",
                style: AppTextStyle.bodyLarge(),
              ),
            )
          ],
        ));
  }
}
