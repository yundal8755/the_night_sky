import 'package:everyones_tone/app/config/app_color.dart';
import 'package:flutter/material.dart';

class BottomSheetIndicator extends StatelessWidget {
  const BottomSheetIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: AppColor.neutrals60),
    );
  }
}
