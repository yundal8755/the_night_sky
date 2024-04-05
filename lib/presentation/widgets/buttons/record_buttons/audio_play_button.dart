import 'package:everyones_tone/presentation/pages/record/record_view_model.dart';
import 'package:flutter/material.dart';

class AudioPlayButton extends StatelessWidget {
  final RecordViewModel recordViewModel;
  const AudioPlayButton({super.key, required this.recordViewModel});

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
            onPressed: recordViewModel.audioPlay,
            child: ValueListenableBuilder<bool>(
              valueListenable:
                  recordViewModel.isPlayingNotifier, // isPlaying 상태를 listen
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
              onPressed: () => recordViewModel.resetRecording(),
              child: const Icon(Icons.undo),
            ),
          ),
        ],
      ),
    );
  }
}
