// ignore_for_file: file_names, prefer_const_constructors

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SnsLoginButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final String logo;

  const SnsLoginButton({
    super.key,
    required this.text,
    required this.logo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.neutrals20,
          padding: EdgeInsets.symmetric(vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(logo),
            Gap.size12,
            Text(
              text,
              style: AppTextStyle.bodyLarge(AppColor.neutrals80),
            ),
          ],
        ),
      ),
    );
  }
}
