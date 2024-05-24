import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:flutter/material.dart';

class ProfilePageTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ProfilePageTile({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //color: AppColor.primaryBlue,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(title, style: AppTextStyle.bodyLarge()),
          const Icon(Icons.arrow_forward_ios, color: AppColor.neutrals40),
        ]),
      ),
    );
  }
}
