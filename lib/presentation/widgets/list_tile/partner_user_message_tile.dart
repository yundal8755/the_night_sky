// ignore_for_file: file_names, prefer_const_constructors

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/presentation/widgets/audio_player/circle_audio_player.dart';
import 'package:flutter/material.dart';

class PartnerUserMessageTile extends StatelessWidget {
  final String audioUrl;
  final String backgroundImage;
  final String nickname;
  final String dateCreated;

  const PartnerUserMessageTile(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAudioPlayer(
                audioUrl: audioUrl,
                backgroundImage: backgroundImage,
                pauseIconSize: AppAssets.pauseDefault32,
                playIconSize: AppAssets.playDefault32,
                radius: 32,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nickname,
                    style: AppTextStyle.bodyMedium(),
                  ),
                  Text(dateCreated,
                      style: TextStyle(color: AppColor.neutrals60))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
