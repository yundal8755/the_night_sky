import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/presentation/pages/record/record_view_model.dart';
import 'package:flutter/material.dart';

class RecordingButton extends StatelessWidget {
  final RecordViewModel recordViewModel;
  const RecordingButton({super.key, required this.recordViewModel});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(24),
        backgroundColor: Colors.transparent,
        side: const BorderSide(color: AppColor.primaryBlue, width: 2.0),
      ),
      onPressed: recordViewModel.stopRecording,
      child: ValueListenableBuilder<int>(
        valueListenable: recordViewModel.remainingTimeNotifier,
        builder: (context, value, child) {
          return Center(
            child: SizedBox(
              child: Text(
                '$value',
                style: AppTextStyle.headlineLarge()
              ),
            ),
          );
        },
      ),
    );
  }
}
