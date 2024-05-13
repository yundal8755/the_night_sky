import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/app/utils/record_status_manager.dart';
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
              builder: (BuildContext context) => AlertDialog(
                    contentPadding: const EdgeInsets.all(12),
                    backgroundColor: AppColor.neutrals90,
                    content: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 4.5,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //! 안내 문구
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.warning_rounded,
                                color: AppColor.neutrals60,
                                size: 48,
                              ),
                              Gap.size4,
                              Text(
                                '상대방에게 답장이 오기 전까지는\n메시지를 보낼 수 없습니다.',
                                style:
                                    AppTextStyle.bodyLarge(AppColor.neutrals20),
                              )
                            ],
                          ),

                          //! 버튼
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColor.neutrals60),
                                child: Center(
                                    child: Text(
                                  '확인',
                                  style: AppTextStyle.bodyMedium(),
                                ))),
                          ),
                        ],
                      ),
                    ),
                  ));
        } else {
          // Otherwise, start recording
          recordStatusManager.startRecording();
        }
      },
      child: SvgPicture.asset(AppAssets.micDefault56),
    );
  }
}
