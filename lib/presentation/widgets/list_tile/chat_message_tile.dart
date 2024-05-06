// ignore_for_file: file_names

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/presentation/widgets/atoms/tone_player.dart';
import 'package:flutter/material.dart';

class ChatMessageTile extends StatelessWidget {
  // final String audioUrl;
  final String backgroundImage;
  final String nickname;

  const ChatMessageTile({
    super.key,
    // required this.audioUrl,
    required this.backgroundImage,
    required this.nickname,
  });

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
              TonePlayer(
                audioUrl: 'abc',
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
                  const Text('안녕하세요',
                      style: TextStyle(color: AppColor.neutrals20))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
