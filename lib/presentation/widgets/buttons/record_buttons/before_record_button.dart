import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/app/utils/record_status_manager.dart';
import 'package:everyones_tone/presentation/widgets/dialog/warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BeforeRecordButton extends StatelessWidget {
  final RecordStatusManager recordStatusManager;
  final bool isLastMessageMine;

  const BeforeRecordButton({
    super.key,
    required this.recordStatusManager,
    this.isLastMessageMine = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
        backgroundColor: AppColor.primaryBlue,
      ),
      onPressed: () {
        if (isLastMessageMine) {
          showDialog(
              context: context,
              builder: (BuildContext context) => const WarningDialog(
                  text: '상대방에게 답장이 오기 전까지는\n메시지를 보낼 수 없습니다.'));
        } else {
          // Otherwise, start recording
          recordStatusManager.startRecording();
        }
      },
      child: SvgPicture.asset(AppAssets.micDefault56),
    );
  }
}
