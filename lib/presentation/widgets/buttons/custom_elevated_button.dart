// ignore_for_file: must_be_immutable

import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  Color backgroundColor;
  String text;
  Color textColor;
  Color borderSideColor;
  VoidCallback? onPressed;
  CustomElevatedButton(
      {super.key,
      required this.backgroundColor,
      required this.text,
      required this.textColor,
      required this.onPressed,
      this.borderSideColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          side: BorderSide(color: borderSideColor),
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Text(text, style: AppTextStyle.bodyLarge(textColor)),
      ),
    );
  }
}
