// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_sites.dart';
import 'package:everyones_tone/presentation/pages/login/login_view_model.dart';
import 'package:everyones_tone/presentation/pages/login/sns_login_page.dart';
import 'package:everyones_tone/presentation/pages/web_view_page.dart';
import 'package:everyones_tone/presentation/widgets/custom_buttons/main_button.dart';
import 'package:everyones_tone/presentation/widgets/tiles/login_page_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitialLoginPage extends StatelessWidget {
  const InitialLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12.0, bottom: 24.0),
                  child: Text(
                    '밤하늘을 이용하려면 동의가 필요해요',
                    style: AppTextStyle.titleLarge(),
                  ),
                ),
                LoginPageTile(
                  title: '서비스 이용약관 (필수)',
                  value: loginViewModel.termsAccepted,
                  onChanged: (value) {
                    loginViewModel.setTermsAccepted(value!);
                  },
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WebViewPage(
                          page: AppSites.termsOfUsePage, title: '서비스 이용약관'),
                    ),
                  ),
                ),
                LoginPageTile(
                  title: '개인정보 처리방침 (필수)',
                  value: loginViewModel.privacyAccepted,
                  onChanged: (value) {
                    loginViewModel.setPrivacyAccepted(value!);
                  },
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WebViewPage(
                          page: AppSites.privacyPolicy, title: '개인정보 처리방침'),
                    ),
                  ),
                ),
              ],
            ),
            MainButton(
              backgroundColor: loginViewModel.isFormValid
                  ? AppColor.primaryBlue
                  : AppColor.neutrals60,
              text: '회원가입/로그인',
              textColor: loginViewModel.isFormValid
                  ? AppColor.neutrals20
                  : AppColor.neutrals40,
              onPressed: loginViewModel.isFormValid
                  ? () async {
                      // await Future.delayed(Duration(milliseconds: 500));
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SnsLoginPage(),
                        ),
                      );
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
