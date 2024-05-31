// ignore_for_file: file_names, avoid_print

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/app/utils/audio_play_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class PlayIconButton extends StatelessWidget {
  final String audioUrl;
  final String playIconSize;
  final String pauseIconSize;

  const PlayIconButton({
    super.key,
    required this.audioUrl,
    this.playIconSize = AppAssets.playDefault32,
    this.pauseIconSize = AppAssets.pauseDefault32,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayProvider>(
      builder: (context, audioPlayProvider, child) {
        bool isCurrentPlaying =
            audioPlayProvider.currentPlayingUrl == audioUrl &&
                audioPlayProvider.isPlaying;

        return IconButton(
          icon: isCurrentPlaying
              ? SvgPicture.asset(pauseIconSize)
              : SvgPicture.asset(playIconSize),
          onPressed: () => audioPlayProvider.togglePlay(audioUrl),
          color: AppColor.neutrals20,
          highlightColor: Colors.transparent,
        );
      },
    );
  }
}
