import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/presentation/widgets/tone_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PostingCard extends StatelessWidget {
  final String profilePicUrl;
  final String audioUrl;
  final String postTitle;
  final String nickname;

  const PostingCard(
      {super.key,
      required this.profilePicUrl,
      required this.audioUrl,
      required this.nickname,
      required this.postTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height / 1.7,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColor.neutrals80,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // 음성 재생 버튼
          TonePlayer(
              audioUrl: audioUrl,
              backgroundImage: profilePicUrl,
              pauseIconSize: AppAssets.pauseDefault56,
              playIconSize: AppAssets.playDefault56),

          // 게시글 정보
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '모두의 음색',
                style: AppTextStyle.bodyMedium(AppColor.primaryBlue),
              ),
              Gap.size6,
              Text(
                postTitle,
                style: AppTextStyle.titleLarge(),
              ),
              Gap.size6,
              Text(
                nickname,
                style: AppTextStyle.bodyMedium(AppColor.neutrals40),
              ),
            ],
          ),

          // 답장 버튼
          Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppAssets.messageDefault32),
            ),
          ),
        ],
      ),
    );
  }
}
