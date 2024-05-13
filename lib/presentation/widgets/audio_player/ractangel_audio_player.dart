import 'package:everyones_tone/presentation/widgets/buttons/play_icon_button.dart';
import 'package:flutter/material.dart';

class RectangleAudioPlayer extends StatelessWidget {
  final String backgroundImage;
  final String audioUrl;
  final String pauseIconSize;
  final String playIconSize;
  final double widthSize;
  final double heightSize;
  final double opacity;
  const RectangleAudioPlayer(
      {super.key,
      required this.audioUrl,
      required this.backgroundImage,
      required this.pauseIconSize,
      required this.playIconSize,
      required this.widthSize,
      required this.heightSize,
      required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: opacity,
          child: Container(
            width: widthSize,
            height: heightSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
              image: DecorationImage(
                  image: AssetImage(backgroundImage), fit: BoxFit.cover),
            ),
          ),
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
