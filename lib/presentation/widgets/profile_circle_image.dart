// ignore_for_file: file_names

import 'package:flutter/material.dart';

///
/// enum 값은 32, 72, 112, 262 ?!
/// enum으로 선택할 수 있게 구현하기
/// 

class ProfileCircleImage extends StatelessWidget {
  final double radius;
  final String backgroundImage;

  const ProfileCircleImage({
    super.key,
    required this.radius,
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: AssetImage(backgroundImage),
    );
  }
}
