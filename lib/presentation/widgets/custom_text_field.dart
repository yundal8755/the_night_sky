import "package:everyones_tone/app/config/app_color.dart";
import "package:everyones_tone/app/config/app_text_style.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;

  const CustomTextField({
    required this.hintText,
    required this.textEditingController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '게시글 제목',
            style: AppTextStyle.labelMedium(AppColor.neutrals40),
          ),
          TextField(
            cursorColor: AppColor.primaryBlue,
            controller: textEditingController,
            inputFormatters: [
              LengthLimitingTextInputFormatter(20), // 입력 길이를 20자로 제한
            ],
            style: AppTextStyle.headlineLarge(),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintText: hintText,
              hintStyle: AppTextStyle.headlineLarge(AppColor.neutrals60),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
