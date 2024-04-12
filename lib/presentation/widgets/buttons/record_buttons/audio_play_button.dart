import 'package:everyones_tone/presentation/widgets/record/record_status_manager.dart';
import 'package:flutter/material.dart';

class AudioPlayButton extends StatelessWidget {
  final RecordStatusManager recordStatusManager;
  const AudioPlayButton({super.key, required this.recordStatusManager});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 30),
            width: 55,
            height: 55,
          ),

          // 재생, 일시정지 버튼
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(24),
            ),
            onPressed: recordStatusManager.audioPlay,
            child: ValueListenableBuilder<bool>(
              valueListenable:
                  recordStatusManager.isPlayingNotifier, // isPlaying 상태를 listen
              builder: (context, isPlaying, child) {
                return Icon(isPlaying ? Icons.pause : Icons.play_arrow);
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
              child: const Icon(Icons.undo),
            ),
          ),
        ],
      ),
    );
  }
}
