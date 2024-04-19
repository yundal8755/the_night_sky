import 'package:everyones_tone/presentation/widgets/buttons/play_icon_button.dart';
import 'package:everyones_tone/presentation/widgets/profile_circle_image.dart';
import 'package:flutter/material.dart';

class TonePlayer extends StatelessWidget {
  final String backgroundImage;
  final String audioUrl;
  final String pauseIconSize;
  final String playIconSize;
  const TonePlayer(
      {super.key,
      required this.audioUrl,
      required this.backgroundImage,
      required this.pauseIconSize,
      required this.playIconSize});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ProfileCircleImage(
          radius: MediaQuery.of(context).size.width / 2.75,
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
