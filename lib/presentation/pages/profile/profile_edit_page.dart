// ignore_for_file: use_build_context_synchronously

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/app/utils/bottom_sheet.dart';
import 'package:everyones_tone/app/utils/firestore_user_provider.dart';
import 'package:everyones_tone/presentation/pages/bottom_nav_bar/bottom_nav_bar_page.dart';
import 'package:everyones_tone/presentation/pages/edit_profile/edit_profile_page.dart';
import 'package:everyones_tone/presentation/pages/login/login_view_model.dart';
import 'package:everyones_tone/presentation/widgets/custom_dialog.dart';
import 'package:everyones_tone/presentation/widgets/atoms/profile_circle_image.dart';
import 'package:everyones_tone/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginViewModel loginViewModel = LoginViewModel();
    final userData = Provider.of<FirestoreUserProvider>(context).userData;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.neutrals90,
        leading: const BackButton(color: AppColor.neutrals20),
        title: const Text(
          '프로필 수정',
          style: TextStyle(color: AppColor.neutrals20),
        ),
      ),
      backgroundColor: AppColor.neutrals90,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //! 프로필 사진, 닉네임

            Column(
              children: [
                Gap.size12,
                // 프로필 사진
                ProfileCircleImage(
                    radius: MediaQuery.of(context).size.width / 6,
                    backgroundImage: userData == null
                        ? AppAssets.profileBasicImage
                        : userData['profilePicUrl']),
                Gap.size12,
                // 닉네임
                Text(
                  userData == null ? '로그인을 해주세요' : userData['nickname'],
                  style: AppTextStyle.titleLarge(),
                ),
                Gap.size48,
              ],
            ),

            //! 버튼
            Column(
              children: [
                // 프로필 변경 버튼
                CustomElevatedButton(
                  backgroundColor: AppColor.primaryBlue,
                  text: '프로필 변경',
                  textColor: AppColor.neutrals20,
                  onPressed: () {
                    bottomSheet(
                      context: context,
                      child: const EditProfilePage(),
                      bottomSheetType: BottomSheetType.postPage,
                    );
                  },
                ),

                // 로그아웃 버튼
                CustomElevatedButton(
                  backgroundColor: Colors.transparent,
                  text: '로그아웃',
                  textColor: AppColor.neutrals20,
                  borderSideColor: AppColor.primaryBlue,
                  onPressed: () {
                    showDialog(
                      barrierColor: AppColor.neutrals90.withOpacity(0.95),
                      context: context,
                      builder: (BuildContext context) => CustomDialog(
                        title: '로그아웃',
                        message: '정말 로그아웃 하시겠습니까?',
                        onConfirm: () async {
                          loginViewModel.signOut();

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavBarPage(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                        mainButtonTitle: '로그아웃',
                      ),
                    );
                  },
                ),

                // 회원탈퇴 버튼
                TextButton(
                    onPressed: () {
                      showDialog(
                        barrierColor: AppColor.neutrals90.withOpacity(0.95),
                        context: context,
                        builder: (BuildContext context) => CustomDialog(
                          title: '정말 탈퇴하시겠어요?',
                          message: '계정은 삭제되며 복구되지 않습니다.',
                          onConfirm: () async {
                            await loginViewModel.deleteUserAccount();

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomNavBarPage(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                          mainButtonTitle: '회원탈퇴',
                        ),
                      );
                    },
                    child: Text(
                      '회원탈퇴',
                      style: AppTextStyle.bodyLarge(AppColor.neutrals60),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
