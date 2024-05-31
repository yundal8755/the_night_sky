import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  Color backgroundColor;
  String text;
  Color borderSideColor;
  VoidCallback? onTap;
  DialogButton(
      {super.key,
      required this.backgroundColor,
      required this.text,
      required this.onTap,
      this.borderSideColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyle.labelMedium(),
          ),
        ),
      ),
    );
  }
}
