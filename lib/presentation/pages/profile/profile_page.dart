// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/app/repository/database_helper.dart';
import 'package:everyones_tone/app/utils/firestore_user_provider.dart';
import 'package:everyones_tone/presentation/pages/profile/profile_edit_page.dart';
import 'package:everyones_tone/presentation/pages/web_view_page.dart';
import 'package:everyones_tone/presentation/widgets/atoms/profile_circle_image.dart';
import 'package:everyones_tone/presentation/widgets/list_tile/profile_page_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<FirestoreUserProvider>(context).userData;

    return Scaffold(
      backgroundColor: AppColor.neutrals90,
      appBar: AppBar(
          leading: BackButton(
            color: AppColor.neutrals20,
          ),
          backgroundColor: AppColor.neutrals90,
          title: Text('내 정보', style: TextStyle(color: AppColor.neutrals20))),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              //! 프로필 사진, 닉네임
              Column(
                children: [
                  Gap.size12,
                  // 프로필 사진
                  ProfileCircleImage(
                    radius: MediaQuery.of(context).size.width / 6,
                    backgroundImage:  userData == null 
                    ? AppAssets.profileBasicImage
                    : userData['profilePicUrl'],
                    
                    
                  ),
                  Gap.size12,
                  // 닉네임
                  Text(
                    userData == null ? '로그인을 해주세요' : userData['nickname'],
                    style: AppTextStyle.titleLarge(),
                  ),
                  Gap.size48,
                ],
              ),

              //! 프로필
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text('프로필',
                          style: AppTextStyle.labelLarge(AppColor.neutrals60))),
                  ProfilePageTile(
                    title: '프로필 수정',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileEditPage()));
                    },
                  ),
                ],
              ),
              Gap.size24,

              //! 고객센터
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text('고객센터',
                          style: AppTextStyle.labelLarge(AppColor.neutrals60))),
                  ProfilePageTile(
                      title: '공지사항',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebViewPage()));
                      }),
                  ProfilePageTile(
                      title: '자주 묻는 질문',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebViewPage()));
                      }),
                  ProfilePageTile(
                      title: '서비스 이용약관',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebViewPage()));
                      }),
                ],
              ),
              Gap.size24,

              ElevatedButton(
                onPressed: () async {
                  final databaseHelper = DatabaseHelper();
                  await databaseHelper.deleteDatabaseFile();
                },
                child: Text(
                  'DB 파일 삭제',
                  style: AppTextStyle.bodyMedium(AppColor.neutrals80),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
