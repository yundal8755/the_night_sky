import 'package:everyones_tone/app/config/app_color.dart';
import 'package:flutter/material.dart';

class BottomSheetIndicator extends StatelessWidget {
  const BottomSheetIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0, bottom: 4.0),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: AppColor.neutrals60),
    );
  }
}
