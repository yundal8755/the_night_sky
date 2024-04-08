import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/utils/bottom_sheet.dart';
import 'package:everyones_tone/app/utils/firestore_data.dart';
import 'package:everyones_tone/presentation/pages/login/login_page.dart';
import 'package:everyones_tone/presentation/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final _currentUser = FirestoreData().currentUser;
  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      bottomSheet(
          context: context,
          child: LoginPage(),
          bottomSheetType: BottomSheetType.postPage);
    }

    // MediaQuery를 사용하여 화면의 너비와 높이를 얻습니다.
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Paint 객체 생성
    final primaryPaint = Paint()
      ..shader = AppColor.primaryGradient
          .createShader(Rect.fromLTWH(0, 0, screenWidth, screenHeight / 256));

    final textStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      // foreground 속성을 사용하여 Paint 객체를 설정
      foreground: primaryPaint,
    );

    return PopScope(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MainAppBar(title: '채팅방'),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_currentUser == null) const Text('로그인 해주세요!'),
                if (_currentUser != null)
                  Column(children: [
                    Text(
                      '당신의 음색을 녹음해주세요!',
                      style: textStyle,
                    ),
                  ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
