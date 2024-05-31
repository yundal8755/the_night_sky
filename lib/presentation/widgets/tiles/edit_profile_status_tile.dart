import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/app/enums/record_status.dart';
import 'package:everyones_tone/app/utils/bottom_sheet.dart';
import 'package:everyones_tone/app/repository/firestore_data.dart';
import 'package:everyones_tone/app/utils/edit_profile_manager.dart';
import 'package:everyones_tone/presentation/pages/profile/edit_profile_page.dart';
import 'package:everyones_tone/presentation/widgets/profile_circle_image.dart';
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

  Map<String, dynamic> userData = {};
  String profilePicUrl = AppAssets.profileBasicImage;
  String nickname = '닉네임';

  @override
  void initState() {
    super.initState();
    FirestoreData.fetchUserData().then((data) {
      if (mounted) {
        setState(
          () {
            userData = data!;
            profilePicUrl = FirestoreData.currentUser == null
                ? AppAssets.profileBasicImage
                : userData['profilePicUrl'];

            nickname = FirestoreData.currentUser == null
                ? '닉네임'
                : userData['nickname'];
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
