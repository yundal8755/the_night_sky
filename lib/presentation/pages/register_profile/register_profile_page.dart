// ignore_for_file: avoid_print

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/presentation/pages/bottom_nav_bar/bottom_nav_bar_page.dart';
import 'package:everyones_tone/presentation/pages/edit_profile/edit_profile_manager.dart';
import 'package:everyones_tone/presentation/pages/register_profile/register_profile_view_model.dart';
import 'package:everyones_tone/presentation/widgets/background_gradient.dart';
import 'package:everyones_tone/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:everyones_tone/presentation/widgets/profile_circle_image.dart';
import 'package:flutter/material.dart';

class RegisterProfilePage extends StatelessWidget {
  final String userEmail;
  final RegisterProfileViewModel registerProfileViewModel =
      RegisterProfileViewModel();
  final EditProfileManager editProfileInfoViewModel = EditProfileManager();
  RegisterProfilePage({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BackgroundGradient(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            title: Text(
              '회원가입',
              style: AppTextStyle.headlineLarge(),
            ),
          ),
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //! 프로필 사진, 닉네임
                  Column(
                    children: [
                      Gap.size24,
                      ValueListenableBuilder<String>(
                        valueListenable: editProfileInfoViewModel.profilePicUrl,
                        builder: (context, backgroundImage, _) {
                          return ProfileCircleImage(
                            radius: MediaQuery.of(context).size.width / 6,
                            backgroundImage: backgroundImage,
                          );
                        },
                      ),
                      Gap.size16,
                      ValueListenableBuilder<String>(
                        valueListenable: editProfileInfoViewModel.nickname,
                        builder: (context, value, _) {
                          return Text(value, style: AppTextStyle.titleLarge());
                        },
                      ),
                    ],
                  ),

                  //! 버튼
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 시작하기 버튼
                      CustomElevatedButton(
                        backgroundColor: AppColor.primaryBlue,
                        text: '🚀 시작하기',
                        textColor: AppColor.neutrals20,
                        onPressed: () async {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavBarPage(),
                            ),
                            (Route<dynamic> route) => false,
                          );

                          await registerProfileViewModel.registerUserData(
                              userEmail: userEmail,
                              nickname: editProfileInfoViewModel.nickname.value,
                              profilePicUrl:
                                  editProfileInfoViewModel.profilePicUrl.value);
                        },
                      ),

                      // 프로필 변경 버튼
                      CustomElevatedButton(
                        backgroundColor: Colors.transparent,
                        text: '♻️ 프로필 변경',
                        textColor: AppColor.neutrals20,
                        borderSideColor: AppColor.primaryBlue,
                        onPressed: () {
                          editProfileInfoViewModel.generateRandomNickname();
                          editProfileInfoViewModel.generateRandomProfileImage();
                        },
                      ),

                      Gap.size24,
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
