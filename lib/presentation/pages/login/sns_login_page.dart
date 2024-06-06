// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';
import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/presentation/pages/bottom_nav_bar_page.dart';
import 'package:everyones_tone/presentation/pages/login/login_view_model.dart';
import 'package:everyones_tone/presentation/pages/register_profile/register_profile_page.dart';
import 'package:everyones_tone/presentation/widgets/custom_buttons/sns_login_button.dart';
import 'package:everyones_tone/presentation/widgets/layout/main_background_layout.dart';
import 'package:flutter/material.dart';

class SnsLoginPage extends StatelessWidget {
  final LoginViewModel loginViewModel = LoginViewModel();

  SnsLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainBackgroundLayout(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const BackButton(color: AppColor.neutrals20),
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '원하는 로그인 방식을 선택해주세요!',
                      style: AppTextStyle.headlineMedium(),
                    ),
                    Gap.size12,
                    Text(
                      '중복 가입을 막고, 악성 사용자를 제재하는데 사용합니다.',
                      style: AppTextStyle.bodyMedium(AppColor.neutrals20),
                    )
                  ],
                ),
              ),
              Column(
                children: [
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
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
