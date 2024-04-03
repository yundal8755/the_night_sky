import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/presentation/pages/profile/profile_page.dart';
import 'package:everyones_tone/app/utils/bottom_sheet.dart';
import 'package:everyones_tone/presentation/widgets/atoms/profile_circle_image.dart';
import 'package:flutter/material.dart';

///
/// HomePage, ChatPage에서 사용되는 Custom된 MainAppBar이다.
///

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MainAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyle.headlineLarge(),
      ),
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: () {
              bottomSheet(
                  context: context,
                  child: MyProfilePage(),
                  bottomSheetType: BottomSheetType.profilePage);
            },
            child: const ProfileCircleImage(
                radius: 16, backgroundImage: AppAssets.profileRandomImage2),
          ),
        )
      ],
    );
  }

  @override
  // AppBar의 기본 높이 설정
  // kToolbarHeight는 일반적으로 56.0이다.
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
