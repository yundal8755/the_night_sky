// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/enums/record_status.dart';
import 'package:everyones_tone/app/utils/firestore_data.dart';
import 'package:everyones_tone/presentation/pages/post/post_view_model.dart';
import 'package:everyones_tone/presentation/pages/record/record_page.dart';
import 'package:everyones_tone/presentation/pages/record/record_view_model.dart';
import 'package:everyones_tone/presentation/widgets/custom_text_field.dart';
import 'package:everyones_tone/presentation/widgets/sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String hintText = '제목을 입력해주세요!';
    final PostViewModel postViewModel = PostViewModel();
    final FirestoreData firestoreData = FirestoreData();
    final recordViewModel =
        Provider.of<RecordViewModel>(context, listen: false);
    final textEditingController = TextEditingController();

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SubAppBar(
                title: '음색 업로드',
                onPressed: () async {
                  //! Progress Indicator
                  showDialog(
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

                  // ! 업로드에 필요한 포스팅 정보 확보하기
                  // 글 제목
                  String postTitle = textEditingController.text.isEmpty
                      ? hintText
                      : textEditingController.text;
                  // 오디오 URL
                  String audioUrl = recordViewModel.audioFilePath!;

                  // Firestore에 저장된 User의 Data
                  Map<String, dynamic>? userData =
                      await firestoreData.fetchUserData();

                  await postViewModel.uploadPost(
                      postTitle: postTitle,
                      audioUrl: audioUrl,
                      userData: userData!);

                  //! RecordStatus, audioUrl 초기화
                  recordViewModel.recordingStatusNotifier.value =
                      RecordStatus.before;
                  recordViewModel.audioFilePath = null;

                  //! Route
                  Navigator.pop(context); // 다이얼로그 닫기
                  Navigator.pop(context); // Home으로 이동
                },
              ),
              CustomTextField(
                hintText: hintText,
                textEditingController: textEditingController,
              ),
            ],
          ),
          RecordPage()
        ],
      ),
    );
  }
}
