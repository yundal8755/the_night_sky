// ignore_for_file: file_names

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/presentation/widgets/audio_player/circle_audio_player.dart';
import 'package:flutter/material.dart';

class CurrentUserMessageTile extends StatelessWidget {
  final String audioUrl;
  final String backgroundImage;
  final String nickname;
  final String dateCreated;

  const CurrentUserMessageTile(
      {super.key,
      required this.audioUrl,
      required this.backgroundImage,
      required this.nickname,
      required this.dateCreated});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    nickname,
                    style: AppTextStyle.bodyMedium(),
                  ),
                  Text(dateCreated,
                      style: const TextStyle(color: AppColor.neutrals60))
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              CircleAudioPlayer(
                audioUrl: audioUrl,
                backgroundImage: backgroundImage,
                pauseIconSize: AppAssets.pauseDefault32,
                playIconSize: AppAssets.playDefault32,
                radius: 32,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
