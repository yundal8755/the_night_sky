import 'package:everyones_tone/app/style/app_color.dart';
import 'package:everyones_tone/app/style/app_gap.dart';
import 'package:everyones_tone/app/style/app_text_style.dart';
import 'package:everyones_tone/app/constant/app_assets.dart';
import 'package:everyones_tone/app/enum/record_status.dart';
import 'package:everyones_tone/app/util/bottom_sheet.dart';
import 'package:everyones_tone/app/util/edit_profile_manager.dart';
import 'package:everyones_tone/app/service/firebase_service.dart';
import 'package:everyones_tone/common/model/user_model.dart';
import 'package:everyones_tone/feature/profile/edit_profile_page.dart';
import 'package:everyones_tone/common/widget/profile_circle_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileStatusTile extends StatefulWidget {
  const EditProfileStatusTile({super.key});

  @override
  State<EditProfileStatusTile> createState() => _EditProfileStatusTileState();
}

class _EditProfileStatusTileState extends State<EditProfileStatusTile> {
  final EditProfileManager editProfileManager = EditProfileManager();
  final recordingStatusNotifier =
      ValueNotifier<RecordStatus>(RecordStatus.before);

  UserModel? userData;
  String profilePicUrl = AppAssets.profileBasicImage;
  String nickname = '닉네임';

  @override
  void initState() {
    super.initState();
    FirebaseService.fetchCurrentUser().then((data) {
      if (mounted) {
        setState(
          () {
            userData = data;
            profilePicUrl = FirebaseService.currentUser == null
                ? AppAssets.profileBasicImage
                : (userData?.profilePicUrl ?? AppAssets.profileBasicImage);

            nickname = FirebaseService.currentUser == null
                ? '닉네임'
                : (userData?.nickname ?? '닉네임');
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final editProfileManager = Provider.of<EditProfileManager>(context);
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              //! 프로필 사진
              ProfileCircleImage(
                radius: 32,
                backgroundImage: profilePicUrl,
              ),
              Gap.size16,

              //! 닉네임, getMessageText
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 닉네임
                  Text(nickname, style: AppTextStyle.bodyLarge()),
                  Gap.size02,
                  // 녹음 상태 메시지
                  ValueListenableBuilder<RecordStatus>(
                    valueListenable: recordingStatusNotifier,
                    builder: (context, status, child) {
                      return Text(
                        '음성을 녹음해주세요!',
                        style: AppTextStyle.labelMedium(AppColor.primaryBlue),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          //! EditProfiePage 이동 아이콘
          IconButton(
            splashColor: AppColor.neutrals20,
            onPressed: () {
              bottomSheet(
                  context: context,
                  child: const EditProfilePage(),
                  bottomSheetType: BottomSheetHeight.postPage);
            },
            icon:
                const Icon(Icons.arrow_forward_ios, color: AppColor.neutrals40),
          )
        ],
      ),
    );
  }
}
