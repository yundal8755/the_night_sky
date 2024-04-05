import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/presentation/pages/record/record_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BeforeRecordButton extends StatelessWidget {
  final RecordViewModel recordViewModel;
  const BeforeRecordButton({super.key, required this.recordViewModel});

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
        backgroundColor: AppColor.primaryBlue,
      ),
      onPressed: recordViewModel.startRecording,
      child: SvgPicture.asset(AppAssets.micDefault56),
    );
  }
}
