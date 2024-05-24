// ignore_for_file: file_names, avoid_print, prefer_const_constructors, library_private_types_in_public_api, unrelated_type_equality_checks

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/app/repository/firestore_data.dart';
import 'package:everyones_tone/presentation/widgets/atoms/profile_circle_image.dart';
import 'package:flutter/cupertino.dart';

class AnonymousProfileSwitch extends StatefulWidget {
  final Function(String nickname, String profilePicUrl) onProfileChanged;

  const AnonymousProfileSwitch({super.key, required this.onProfileChanged});

  @override
  _AnonymousProfileSwitchState createState() => _AnonymousProfileSwitchState();
}

class _AnonymousProfileSwitchState extends State<AnonymousProfileSwitch> {
  bool isSwitched = false;
  String nickname = '';
  String profilePicUrl = AppAssets.profileBasicImage;
  Map<String, dynamic> userData = {};
  List<String> randomImages = List.generate(
    20,
    (index) => 'assets/images/profile_random_image_${(index + 1).toString().padLeft(2, '0')}.jpeg',
  );

  @override
  void initState() {
    super.initState();
    FirestoreData.fetchUserData().then((data) {
      if (mounted) {
        setState(() {
          userData = data!;
          profilePicUrl = FirestoreData.currentUser == null
              ? AppAssets.profileBasicImage
              : userData['profilePicUrl'];
          nickname =
              FirestoreData.currentUser == null ? '닉네임' : userData['nickname'];
          widget.onProfileChanged(nickname, profilePicUrl); // 초기값 전달
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              ProfileCircleImage(
                radius: 32,
                backgroundImage: profilePicUrl,
              ),
              Gap.size16,
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nickname, style: AppTextStyle.bodyLarge()),
                  Gap.size02,
                  Text(
                    '음성을 녹음해주세요!',
                    style: AppTextStyle.labelMedium(AppColor.primaryBlue),
                  ),
                ],
              ),
            ],
          ),
          CupertinoSwitch(
            activeColor: AppColor.primaryBlue,
            value: isSwitched,
            onChanged: (bool value) {
              setState(() {
                isSwitched = value;
                if (isSwitched) {
                  nickname = '익명';
                  randomImages.shuffle();
                  profilePicUrl = randomImages.first;
                } else {
                  nickname = userData['nickname'];
                  profilePicUrl = userData['profilePicUrl'];
                }
                widget.onProfileChanged(nickname, profilePicUrl); // 값 변경 시 전달
              });
            },
          ),
        ],
      ),
    );
  }
}
