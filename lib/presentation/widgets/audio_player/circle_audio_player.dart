import 'package:everyones_tone/presentation/widgets/profile_circle_image.dart';
import 'package:everyones_tone/presentation/widgets/custom_buttons/play_icon_button.dart';
import 'package:flutter/material.dart';

class CircleAudioPlayer extends StatelessWidget {
  final String backgroundImage;
  final String audioUrl;
  final String pauseIconSize;
  final String playIconSize;
  final double radius;
  const CircleAudioPlayer(
      {super.key,
      required this.audioUrl,
      required this.backgroundImage,
      required this.pauseIconSize,
      required this.playIconSize,
      required this.radius
      });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ProfileCircleImage(
          radius: radius,
          opacity: 0.3,
          backgroundImage: backgroundImage,
        ),
        PlayIconButton(
          audioUrl: audioUrl,
          pauseIconSize: pauseIconSize,
          playIconSize: playIconSize,
        )
      ],
    );
  }
}
