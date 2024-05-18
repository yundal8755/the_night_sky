import 'package:everyones_tone/app/config/app_color.dart';
import 'package:flutter/material.dart';

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

      // child: Stack(
      //   children: [
      //     Container(
      //       decoration: BoxDecoration(
      //         image: DecorationImage(
      //           image: AssetImage(AppAssets.profileRandomImage11),
      //           fit: BoxFit.cover,
      //           colorFilter: ColorFilter.mode(
      //             Colors.black.withOpacity(0.20), // 5% 투명도의 검정색 오버레이
      //             BlendMode.dstATop,
      //           ),
      //         ),
      //       ),
      //     ),
      //     child
      //   ],
      // ),