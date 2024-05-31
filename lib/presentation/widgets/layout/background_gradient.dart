import 'package:everyones_tone/app/config/app_color.dart';
import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {
  final Widget child;
  const BackgroundGradient({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    const backgroundDecoration = BoxDecoration(
      gradient: AppColor.backgroundGradient,
    );

    return Container(
      decoration: backgroundDecoration,
      child: child,
    );
  }
}
