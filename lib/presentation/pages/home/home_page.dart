import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/presentation/widgets/molecules/main_app_bar.dart';
import 'package:flutter/material.dart';

///
/// 사용자의 게시물을 ListViewBuilder 형식으로 나열하는 페이지입니다.
/// Firestore의 메타데이터 정보를 화면에 보여주는 역할을 합니다.
/// 현재는 한 페이지 당 하나의 게시물만 볼 수 있도록 구성할 계획입니다.
///

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MainAppBar(title: '홈'),
        body: SafeArea(
          child: Center(
              child: Card(
            color: AppColor.neutrals80,
          )),
        ),
      ),
    );
  }
}
