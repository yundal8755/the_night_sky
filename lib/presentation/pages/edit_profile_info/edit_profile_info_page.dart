import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/app/enums/record_status.dart';
import 'package:everyones_tone/presentation/pages/edit_profile_info/edit_profile_info_view_model.dart';
import 'package:everyones_tone/presentation/widgets/profile_circle_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EditProfileInfoPage extends StatelessWidget {
  const EditProfileInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final EditProfileInfoViewModel editProfileInfoViewModel =
        EditProfileInfoViewModel();

    final recordingStatusNotifier =
        ValueNotifier<RecordStatus>(RecordStatus.before);
    String _getMessageText(RecordStatus status) {
      switch (status) {
        case RecordStatus.before:
          return '음성을 녹음해주세요!';
        case RecordStatus.recording:
          return '음성을 녹음중이에요!';
        case RecordStatus.complete:
          return '음성 녹음이 완료됐어요!';
        default:
          return '';
      }
    }

    RecordStatus recordStatus = recordingStatusNotifier.value;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              //! 프로필 사진
              ValueListenableBuilder<String>(
                valueListenable: editProfileInfoViewModel.profilePicUrl,
                builder: (context, backgroundImage, _) {
                  return ProfileCircleImage(
                    radius: 32,
                    backgroundImage: backgroundImage,
                  );
                },
              ),
              Gap.size16,

              //! 닉네임, getMessageText
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 닉네임
                  ValueListenableBuilder<String>(
                    valueListenable: editProfileInfoViewModel.nickname,
                    builder: (context, value, _) {
                      return Text(value, style: AppTextStyle.bodyMedium());
                    },
                  ),
                  // 녹음 상태 메시지
                  ValueListenableBuilder<RecordStatus>(
                    valueListenable: recordingStatusNotifier,
                    builder: (context, status, child) {
                      String messageText = _getMessageText(recordStatus);
                      return Text(
                        messageText,
                        style: AppTextStyle.labelMedium(AppColor.primaryBlue),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          //! Refresh Button
          IconButton(
              onPressed: () {
                editProfileInfoViewModel.generateRandomNickname();
                editProfileInfoViewModel.generateRandomProfileImage();
              },
              icon: SvgPicture.asset(AppAssets.refreshDefault32))
        ],
      ),
    );
  }
}
