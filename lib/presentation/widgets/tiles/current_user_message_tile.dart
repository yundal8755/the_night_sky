// ignore_for_file: file_names

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/presentation/widgets/audio_player/circle_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    // 날짜 포매팅을 위해 DateFormat 사용
    DateFormat inputFormat = DateFormat('MM/dd HH:mm:ss');
    DateFormat outputFormat = DateFormat('MM/dd HH:mm');

    // dateCreated 문자열을 DateTime 객체로 파싱
    DateTime dateTime = inputFormat.parse(dateCreated);
    // 새로운 포맷으로 날짜 포맷팅
    String formattedDate = outputFormat.format(dateTime);

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
                    style: AppTextStyle.bodyLarge(),
                  ),
                  Gap.size02,
                  Text(formattedDate,
                      style: AppTextStyle.labelMedium(AppColor.neutrals60))
                ],
              ),
              Gap.size16,
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
