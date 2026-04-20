import 'package:everyones_tone/app/style/app_color.dart';
import 'package:everyones_tone/app/util/record_status_manager.dart';
import 'package:everyones_tone/presentation/post/post_view_model.dart';
import 'package:everyones_tone/presentation/common/widget/anonymous_profile_switch.dart';
import 'package:everyones_tone/presentation/common/widget/app_bar/sub_app_bar.dart';
import 'package:everyones_tone/presentation/common/widget/custom_text_field.dart';
import 'package:everyones_tone/presentation/common/widget/record_buttons/record_status_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///
/// 게시글 작성 페이지
///
class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostViewModel(),
      child: const _PostPageView(),
    );
  }
}

class _PostPageView extends StatelessWidget {
  const _PostPageView();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PostViewModel>(context);
    final recordStatusManager =
        Provider.of<RecordStatusManager>(context, listen: false);

    return SafeArea(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  // 상단 바
                  SubAppBar(
                    title: '게시글 업로드',
                    onPressed: () async {
                      final audioFilePath = recordStatusManager.audioFilePath;
                      if (audioFilePath == null) return;

                      final isSuccess = await vm.uploadPost(audioFilePath);

                      switch (isSuccess) {
                        case true:
                          recordStatusManager.resetToBefore();
                          if (context.mounted) {
                            Navigator.pop(context);
                          }

                        case false:
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('게시글 업로드 실패'),
                              ),
                            );
                          }
                      }
                    },
                  ),

                  // 제목 입력 필드
                  CustomTextField(
                    hintText: vm.hintText,
                    textEditingController: vm.textEditingController,
                  ),

                  // 익명 프로필 스위치
                  AnonymousProfileSwitch(
                    onProfileChanged: (nickname, profilePicUrl) {
                      vm.currentNickname = nickname;
                      vm.currentProfilePicUrl = profilePicUrl;
                    },
                  ),
                ],
              ),
              const RecordStatusButton()
            ],
          ),
          if (vm.isLoading)
            Container(
              color: AppColor.neutrals90.withOpacity(0.5),
              child: const Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    color: AppColor.primaryBlue,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
