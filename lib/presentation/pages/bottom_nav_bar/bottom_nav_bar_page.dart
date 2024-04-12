// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, file_names, library_private_types_in_public_api

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/app/utils/bottom_sheet.dart';
import 'package:everyones_tone/app/utils/firestore_data.dart';
import 'package:everyones_tone/presentation/pages/login/login_page.dart';
import 'package:everyones_tone/presentation/widgets/background_gradient.dart';
import 'package:everyones_tone/presentation/pages/home/home_page.dart';
import 'package:everyones_tone/presentation/pages/post/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../chat/chat_page.dart';

///
/// 왼쪽부터 오른쪽 순으로 HomePage, PostPage, ChatPage를 표시하는 BottomNavBar입니다.
///

class BottomNavBarPage extends StatefulWidget {
  @override
  _BottomNavBarPageState createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    PostPage(),
    ChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BackgroundGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _children[_currentIndex],
        bottomNavigationBar: SafeArea(
          bottom: true,
          child: Container(
            height: 60.0,
            padding: EdgeInsets.only(left: 60.0, right: 60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //! HomePage
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: _currentIndex == 0
                      ? SvgPicture.asset(AppAssets.homePressed32)
                      : SvgPicture.asset(AppAssets.homeDefault32),
                  color: _currentIndex == 0
                      ? AppColor.neutrals20
                      : AppColor.neutrals60,
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                ),

                //! PostPage
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: _currentIndex == 1
                      ? SvgPicture.asset(AppAssets.postDefault32)
                      : SvgPicture.asset(AppAssets.postDefault32),
                  color: _currentIndex == 1
                      ? AppColor.neutrals20
                      : AppColor.neutrals60,
                  onPressed: () {
                    FirestoreData.currentUser == null
                        ? bottomSheet(
                            context: context,
                            child: LoginPage(),
                            bottomSheetType: BottomSheetType.loginPage)
                        : bottomSheet(
                            context: context,
                            child: PostPage(),
                            bottomSheetType: BottomSheetType.postPage);
                  },
                ),

                //! ChatPage
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: _currentIndex == 2
                      ? SvgPicture.asset(AppAssets.chatPressed32)
                      : SvgPicture.asset(AppAssets.chatDefault32),
                  color: _currentIndex == 2
                      ? AppColor.neutrals20
                      : AppColor.neutrals60,
                  onPressed: () {
                    FirestoreData.currentUser == null
                        ? bottomSheet(
                            context: context,
                            child: LoginPage(),
                            bottomSheetType: BottomSheetType.loginPage)
                        : setState(() {
                            _currentIndex = 2;
                          });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
