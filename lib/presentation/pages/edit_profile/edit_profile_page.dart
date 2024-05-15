// ignore_for_file: use_build_context_synchronously

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/presentation/widgets/atoms/profile_circle_image.dart';
import 'package:everyones_tone/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:everyones_tone/presentation/pages/edit_profile/edit_profile_manager.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final EditProfileManager editProfileManager = EditProfileManager();

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //! 프로필 사진, 닉네임
          Column(
            children: [
              //! AppBar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 취소 버튼
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        '취소',
                        style: AppTextStyle.bodyMedium(),
                      ),
                    ),

                    // 모달 제목
                    Text(
                      '프로필 수정',
                      style: AppTextStyle.headlineMedium(),
                    ),

                    TextButton(
                      child: Text(
                        '완료',
                        style: AppTextStyle.bodyLarge(AppColor.primaryBlue),
                      ),
                      onPressed: () async {
                        //! EditProfileManager에 변경된 내용 Firestore의 userData에 전달하기
                        await editProfileManager.editUserData(
                            nickname: editProfileManager.nickname.value,
                            profilePicUrl:
                                editProfileManager.profilePicUrl.value);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Gap.size16,
              //! 프로필 사진
              ValueListenableBuilder<String>(
                valueListenable: editProfileManager.profilePicUrl,
                builder: (context, backgroundImage, _) {
                  return ProfileCircleImage(
                    radius: MediaQuery.of(context).size.width / 6,
                    backgroundImage: backgroundImage,
                  );
                },
              ),
              Gap.size16,

              //! 닉네임
              ValueListenableBuilder<String>(
                valueListenable: editProfileManager.nickname,
                builder: (context, value, _) {
                  return Text(value, style: AppTextStyle.titleLarge());
                },
              ),
            ],
          ),

          //! 프로필 변경 버튼
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: CustomElevatedButton(
              backgroundColor: Colors.transparent,
              text: '♻️ 프로필 변경',
              textColor: AppColor.neutrals20,
              borderSideColor: AppColor.primaryBlue,
              onPressed: () async {
                editProfileManager.generateRandomNickname();
                editProfileManager.generateRandomProfileImage();
              },
            ),
          ),
        ],
      ),
    );
  }
}
