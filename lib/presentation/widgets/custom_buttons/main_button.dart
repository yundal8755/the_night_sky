import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  Color backgroundColor;
  String text;
  Color textColor;
  Color borderSideColor;
  VoidCallback? onPressed;
  MainButton(
      {super.key,
      required this.backgroundColor,
      required this.text,
      required this.textColor,
      required this.onPressed,
      this.borderSideColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: onPressed == null ? AppColor.neutrals60 : backgroundColor,
            border: Border.all(color: borderSideColor),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(text, style: AppTextStyle.titleMedium(textColor)),
          ),
        ),
      ),
    );
  }
}
