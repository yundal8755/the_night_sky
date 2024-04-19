// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/app/utils/bottom_sheet.dart';
import 'package:everyones_tone/app/utils/firestore_data.dart';
import 'package:everyones_tone/presentation/pages/bottom_nav_bar/bottom_nav_bar_page.dart';
import 'package:everyones_tone/presentation/pages/login/login_page.dart';
import 'package:everyones_tone/presentation/pages/login/login_provider.dart';
import 'package:everyones_tone/presentation/pages/login/login_view_model.dart';
import 'package:everyones_tone/presentation/widgets/bottom_sheet_indicator.dart';
import 'package:everyones_tone/presentation/widgets/profile_circle_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MyProfilePage extends StatelessWidget {
  final LoginViewModel loginViewModel = LoginViewModel();

  MyProfilePage({super.key});

  // ListTile 메소드
  Widget buildListTile(BuildContext context, String title, VoidCallback onTap) {
    return ListTile(
        title: Text(title, style: AppTextStyle.bodyMedium()),
        trailing: SvgPicture.asset(AppAssets.pushDefault24),
        onTap: onTap);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: Column(
          children: [
            const BottomSheetIndicator(),

            // 페이지 제목
            Text('내 정보', style: AppTextStyle.headlineMedium()),
            Gap.size24,

            FutureBuilder(
              future: FirestoreData.fetchUserData(),
              builder: (context, snapshot) {
                String? profilePicUrl = snapshot.data?['profilePicUrl'] ??
                    AppAssets.profileRandomImage1;
                String? nickname = snapshot.data?['nickname'] ?? '로그인을 해주세요!';

                //! 로그아웃 상태
                if (!snapshot.hasData) {
                  return Column(
                    children: [
                      // 프로필 사진
                      ProfileCircleImage(
                        radius: MediaQuery.of(context).size.width / 6,
                        backgroundImage: AppAssets.profileBasicImage,
                      ),
                      Gap.size12,

                      // 닉네임
                      Text('로그인을 해주세요!', style: AppTextStyle.titleLarge()),
                      Gap.size48,
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('오류가 발생했습니다.'));
                } 
                
                //! 로그인 상태
                else {
                  return Column(
                    children: [
                      // 프로필 사진
                      ProfileCircleImage(
                        radius: MediaQuery.of(context).size.width / 6,
                        backgroundImage: profilePicUrl!,
                      ),
                      Gap.size12,

                      // 닉네임
                      Text(nickname!, style: AppTextStyle.titleLarge()),
                      Gap.size48,
                    ],
                  );
                }
              },
            ),
            // 프로필 라벨
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text('프로필',
                        style: AppTextStyle.labelLarge(AppColor.neutrals60))),
                buildListTile(context, '프로필 수정', () {}),
              ],
            ),
            Gap.size24,

            // 고객센터 라벨
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text('고객센터',
                        style: AppTextStyle.labelLarge(AppColor.neutrals60))),
                buildListTile(context, '공지사항', () {}),
                buildListTile(context, '자주 묻는 질문', () {}),
                buildListTile(context, '서비스 이용약관', () {}),
              ],
            ),
            Gap.size24,

            if (FirestoreData.currentUser != null)
              ElevatedButton(
                child: Text('로그아웃',
                    style: AppTextStyle.bodyMedium(AppColor.neutrals80)),
                onPressed: () async {
                  await loginViewModel.signOut();
                  // UserProvider에서 사용자를 null로 설정합니다.
                  Provider.of<LoginProvider>(context, listen: false)
                      .setUserData(null);

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavBarPage(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
              )
            else
              ElevatedButton(
                onPressed: () {
                  bottomSheet(
                    context: context,
                    bottomSheetType: BottomSheetType.loginPage,
                    child: LoginPage(),
                  );
                },
                child: Text(
                  '로그인',
                  style: AppTextStyle.bodyMedium(AppColor.neutrals80),
                ),
              ),
          ],
        ));
  }
}
