// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_print

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/app/repository/firestore_data.dart';
import 'package:everyones_tone/presentation/pages/post/post_view_model.dart';
import 'package:everyones_tone/presentation/widgets/atoms/anonymousProfileSwitch.dart';
import 'package:everyones_tone/app/utils/record_status_manager.dart';
import 'package:everyones_tone/presentation/widgets/app_bar/sub_app_bar.dart';
import 'package:everyones_tone/presentation/widgets/atoms/custom_text_field.dart';
import 'package:everyones_tone/presentation/widgets/buttons/record_buttons/record_status_button.dart';
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
                  Map<String, dynamic>? userData =
                      await FirestoreData.fetchUserData();

                  userData!['nickname'] = currentNickname;
                  userData['profilePicUrl'] = currentProfilePicUrl;

                  await postViewModel.uploadPost(
                      postTitle: postTitle,
                      localAudioUrl: localAudioUrl,
                      userData: userData);

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
