import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/utils/record_status_manager.dart';
import 'package:flutter/material.dart';

class RecordingButton extends StatelessWidget {
  final RecordStatusManager recordStatusManager;
  const RecordingButton({super.key, required this.recordStatusManager});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(24),
        backgroundColor: Colors.transparent,
        side: const BorderSide(color: AppColor.primaryBlue, width: 2.0),
      ),
      onPressed: recordStatusManager.stopRecording,
      child: ValueListenableBuilder<int>(
        valueListenable: recordStatusManager.remainingTimeNotifier,
        builder: (context, value, child) {
          return Center(
            child: SizedBox(
              child: Text(
                '$value',
                style: AppTextStyle.headlineMedium()
              ),
            ),
          );
        },
      ),
    );
  }
}
