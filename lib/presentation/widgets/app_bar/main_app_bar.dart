import 'package:everyones_tone/app/style/app_gap.dart';
import 'package:everyones_tone/app/style/app_text_style.dart';
import 'package:everyones_tone/app/constant/app_assets.dart';
import 'package:everyones_tone/app/util/audio_play_provider.dart';
import 'package:everyones_tone/app/util/bottom_sheet.dart';
import 'package:everyones_tone/app/util/firestore_user_provider.dart';
import 'package:everyones_tone/presentation/pages/login/initial_login_page.dart';
import 'package:everyones_tone/presentation/pages/profile/profile_page.dart';
import 'package:everyones_tone/presentation/widgets/profile_circle_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MainAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<FirestoreUserProvider>(context).userData;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: kToolbarHeight,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(padding: EdgeInsets.only(left: 20), child: Gap.size32),
          Text(
            title,
            style: AppTextStyle.headlineMedium(),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
                onTap: () {
                  Provider.of<AudioPlayProvider>(context, listen: false)
                      .stopPlaying();
                  userData == null
                      ? bottomSheet(
                          context: context,
                          child: const InitialLoginPage(),
                          bottomSheetType: BottomSheetHeight.loginPage)
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()));
                },
                child: ProfileCircleImage(
                    radius: 16,
                    opacity: 0.2,
                    backgroundImage: userData == null
                        ? AppAssets.profileBasicImage
                        : userData.profilePicUrl)),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
