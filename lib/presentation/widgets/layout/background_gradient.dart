import 'package:everyones_tone/app/config/app_color.dart';
import 'package:flutter/material.dart';

/// 
/// 메인 그라데이션 배경 Layout
/// 

class BackgroundGradient extends StatelessWidget {
  final Widget child;
  const BackgroundGradient({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // backgroundPaint를 BoxDecoration의 gradient로 변환
    const backgroundDecoration = BoxDecoration(
      gradient: AppColor.backgroundGradient,
    );

    return Container(
      decoration: backgroundDecoration,
      child: child,
    );
  }
}
