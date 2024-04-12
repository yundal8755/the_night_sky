// ignore_for_file: file_names

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:flutter/material.dart';

class ProfileCircleImage extends StatelessWidget {
  final double opacity;
  final double radius;
  final String backgroundImage;

  const ProfileCircleImage({
    super.key,
    this.opacity = 0,
    required this.radius,
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: AssetImage(backgroundImage),
        ),

        // 투명도 조절 컨테이너
        Container(
          width: radius * 2,
          height: radius * 2,
          decoration: BoxDecoration(
              color: AppColor.neutrals80.withOpacity(opacity),
              shape: BoxShape.circle),
        )
      ],
    );
  }
}
