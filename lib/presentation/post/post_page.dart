// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously,

import 'package:everyones_tone/app/style/app_color.dart';
import 'package:everyones_tone/app/constant/app_assets.dart';
import 'package:everyones_tone/app/service/firebase_service.dart';
import 'package:everyones_tone/presentation/post/post_view_model.dart';
import 'package:everyones_tone/presentation/common/widget/anonymous_profile_switch.dart';
import 'package:everyones_tone/app/util/record_status_manager.dart';
import 'package:everyones_tone/presentation/common/widget/app_bar/sub_app_bar.dart';
import 'package:everyones_tone/presentation/common/widget/custom_text_field.dart';
import 'package:everyones_tone/presentation/common/widget/record_buttons/record_status_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String hintText = '제목을 입력해주세요!';
    final PostViewModel postViewModel = PostViewModel();
    final recordStatusManager =
        Provider.of<RecordStatusManager>(context, listen: false);
    final textEditingController = TextEditingController();

    String currentNickname = '';
    String currentProfilePicUrl = AppAssets.profileBasicImage;

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SubAppBar(
                title: '게시글 업로드',
                onPressed: () async {
                  showDialog(
                    barrierColor: AppColor.neutrals90.withOpacity(0.5),
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Center(
                        child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              color: AppColor.primaryBlue,
                            )),
                      );
                    },
                  );
                  String postTitle = textEditingController.text.isEmpty
                      ? hintText
                      : textEditingController.text;
                  String localAudioUrl = recordStatusManager.audioFilePath!;
                  final userData = await FirebaseService.fetchCurrentUser();

                  if (userData == null) {
                    return;
                  }

                  final nickname = currentNickname.isNotEmpty
                      ? currentNickname
                      : userData.nickname;
                  final profilePicUrl = currentProfilePicUrl.isNotEmpty
                      ? currentProfilePicUrl
                      : userData.profilePicUrl;

                  await postViewModel.uploadPost(
                      postTitle: postTitle,
                      localAudioUrl: localAudioUrl,
                      userEmail: userData.userEmail,
                      nickname: nickname,
                      profilePicUrl: profilePicUrl);

                  recordStatusManager.resetToBefore();
                  Navigator.pop(context); // 다이얼로그 닫기
                  Navigator.pop(context); // Home으로 이동
                },
              ),
              CustomTextField(
                hintText: '제목을 입력해주세요!',
                textEditingController: textEditingController,
              ),
              AnonymousProfileSwitch(
                onProfileChanged: (nickname, profilePicUrl) {
                  currentNickname = nickname;
                  currentProfilePicUrl = profilePicUrl;
                },
              ),
            ],
          ),
          RecordStatusButton()
        ],
      ),
    );
  }
}
