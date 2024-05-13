import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/utils/record_status_manager.dart';
import 'package:flutter/material.dart';

class AudioPlayButton extends StatelessWidget {
  final RecordStatusManager recordStatusManager;
  final bool isChatRoomPage;
  final VoidCallback? onPressed;
  const AudioPlayButton(
      {super.key,
      required this.recordStatusManager,
      this.onPressed,
      this.isChatRoomPage = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isChatRoomPage == false
              ? Container(
                  margin: const EdgeInsets.only(right: 30),
                  width: 55,
                  height: 55,
                )
              : Container(
                  margin: const EdgeInsets.only(right: 30),
                  width: 55,
                  height: 55,
                  child: TextButton(
                    onPressed: onPressed,
                    child: Text(
                      '완료',
                      style: AppTextStyle.bodyLarge(AppColor.primaryBlue),
                    ),
                  ),
                ),

          // 재생, 일시정지 버튼
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24),
                backgroundColor: AppColor.primaryBlue),
            onPressed: recordStatusManager.audioPlay,
            child: ValueListenableBuilder<bool>(
              valueListenable:
                  recordStatusManager.isPlayingNotifier,
              builder: (context, isPlaying, child) {
                return Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: AppColor.neutrals20,
                );
              },
            ),
          ),

          // 삭제 버튼
          Container(
            margin: const EdgeInsets.only(left: 30),
            width: 55,
            height: 55,
            child: TextButton(
              onPressed: () => recordStatusManager.resetRecording(),
              child: const Icon(
                Icons.undo,
                color: AppColor.neutrals20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
