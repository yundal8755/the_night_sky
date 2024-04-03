// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/presentation/pages/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:everyones_tone/presentation/pages/login/login_provider.dart';
import 'package:everyones_tone/presentation/pages/login/login_view_model.dart';
import 'package:everyones_tone/presentation/widgets/atoms/bottom_sheet_indicator.dart';
import 'package:everyones_tone/presentation/widgets/atoms/buttons/sns_login_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final LoginViewModel loginViewModel = LoginViewModel();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //! Indicator
        const BottomSheetIndicator(),

        //! Google로 로그인
        SnsLoginButton(
          text: 'Google로 로그인',
          logo: AppAssets.googleLogo,
          onTap: () async {
            // user 정보 전달받기
            var user = await loginViewModel.googleSignInMethod();

            // user가 존재할 때 로직
            if (user != null) {
              bool isRegistered =
                  await loginViewModel.isUserRegistered(user.email!);
              print('isRegistered = $isRegistered');
              if (isRegistered) {
                print('사용자 정보를 업데이트 합니다.');

                // 사용자 정보를 UserProvider에 업데이트
                Provider.of<LoginProvider>(context, listen: false)
                    .setUserData(user);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavBar(),
                  ),
                  (Route<dynamic> route) => false,
                );
              }
            }
          },
        ),

        //! Apple로 로그인
        if (Platform.isIOS)
          SnsLoginButton(
            text: 'Apple로 로그인',
            logo: AppAssets.appleLogo,
            onTap: () async {
              var user = await loginViewModel.appleSignInMethod();
              if (user != null) {
                bool isRegistered =
                    await loginViewModel.isUserRegistered(user.email!);
                if (isRegistered) {
                  // 사용자 정보를 UserProvider에 업데이트
                  Provider.of<LoginProvider>(context, listen: false)
                      .setUserData(user);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavBar(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                }
              }
            },
          ),

        Gap.size16,

        //! 이용약관
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      text: TextSpan(
                          text:
                              '계속하면 당사의 서비스 약관에 동의하고, 개인정보 처리방침을(를) 읽어 당사의 데이터 수집, 사용, 공유 방법을 확인했음을 인정하는 것입니다.',
                          style: AppTextStyle.bodySmall())),
                )
              ],
            )),
      ],
    );
  }
}
