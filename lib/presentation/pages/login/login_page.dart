// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/app/constants/app_sites.dart';
import 'package:everyones_tone/presentation/pages/bottom_nav_bar_page.dart';
import 'package:everyones_tone/presentation/pages/login/login_view_model.dart';
import 'package:everyones_tone/presentation/pages/register_profile/register_profile_page.dart';
import 'package:everyones_tone/presentation/pages/web_view_page.dart';
import 'package:everyones_tone/presentation/widgets/bottom_sheet_indicator.dart';
import 'package:everyones_tone/presentation/widgets/custom_buttons/sns_login_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavBarPage(),
                  ),
                  (Route<dynamic> route) => false,
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterProfilePage(
                      userEmail: user.email!,
                    ),
                  ),
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
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavBarPage(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterProfilePage(
                        userEmail: user.email!,
                      ),
                    ),
                  );
                }
              }
            },
          ),

        Gap.size16,

        //! 이용약관
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    text: TextSpan(
                      text: '계속하면 당사의 ',
                      style: AppTextStyle.bodySmall(),
                      children: [
                        TextSpan(
                          text: '서비스 약관',
                          style: AppTextStyle.bodySmall().copyWith(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WebViewPage(
                                    page: AppSites.termsOfUsePage,
                                    title: '서비스 이용약관',
                                  ),
                                ),
                              );
                            },
                        ),
                        TextSpan(
                          text: '에 동의하고, ',
                          style: AppTextStyle.bodySmall(),
                        ),
                        TextSpan(
                          text: '개인정보 처리방침',
                          style: AppTextStyle.bodySmall().copyWith(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WebViewPage(
                                    page: AppSites.privacyPolicy,
                                    title: '개인정보 처리방침',
                                  ),
                                ),
                              );
                            },
                        ),
                        TextSpan(
                          text:
                              '을(를) 읽어 당사의 데이터 수집, 사용, 공유 방법을 확인했음을 인정하는 것입니다.',
                          style: AppTextStyle.bodySmall(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
