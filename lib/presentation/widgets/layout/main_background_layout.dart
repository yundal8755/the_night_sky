import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:flutter/material.dart';

class MainBackgroundLayout extends StatelessWidget {
  final Widget child;
  const MainBackgroundLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            AppAssets.mainBackgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        child,
      ],
    );
  }
}
