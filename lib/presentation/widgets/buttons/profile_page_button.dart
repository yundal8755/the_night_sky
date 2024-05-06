import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/app/utils/bottom_sheet.dart';
import 'package:everyones_tone/app/repository/firestore_data.dart';
import 'package:everyones_tone/presentation/pages/profile/profile_page.dart';
import 'package:everyones_tone/presentation/widgets/atoms/profile_circle_image.dart';
import 'package:flutter/material.dart';

class ProfilePageButton extends StatelessWidget {
  const ProfilePageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: () {
          bottomSheet(
              context: context,
              child: MyProfilePage(),
              bottomSheetType: BottomSheetType.profilePage);
        },
        child: FutureBuilder(
          future: FirestoreData.fetchUserData(),
          builder: (context, snapshot) {
            String? profilePicUrl =
                snapshot.data?['profilePicUrl'] ?? AppAssets.profileBasicImage;

            if (!snapshot.hasData) {
              return ProfileCircleImage(
                  radius: 16, backgroundImage: profilePicUrl!);
            } else if (snapshot.hasError) {
              return const Center(child: Text('에러가 발생했습니다'));
            } else {
              return ProfileCircleImage(
                  radius: 16, backgroundImage: profilePicUrl!);
            }
          },
        ),
      ),
    );
  }
}
