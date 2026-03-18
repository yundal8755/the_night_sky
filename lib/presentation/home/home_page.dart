import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/style/app_color.dart';
import 'package:everyones_tone/app/provider/audio_play_provider.dart';
import 'package:everyones_tone/presentation/common/widget/app_bar/main_app_bar.dart';
import 'package:everyones_tone/presentation/common/widget/posting_card.dart';
import 'package:everyones_tone/data/model/post_model.dart';
import 'package:everyones_tone/presentation/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = PageController();
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
    _viewModel.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, _) {
          return PopScope(
            canPop: false,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Column(
                  children: [
                    // 메인 앱바
                    const MainAppBar(title: '밤하늘'),

                    // 게시글 리스트
                    Expanded(
                      child: StreamBuilder<QuerySnapshot<PostModel>>(
                        stream: viewModel.postsStream,
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<PostModel>> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColor.primaryBlue,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text(
                                '에러가 발생했습니다',
                                style: TextStyle(color: AppColor.neutrals20),
                              ),
                            );
                          }
                          List<QueryDocumentSnapshot<PostModel>> docs =
                              snapshot.data!.docs;

                          // 필터링: reportedPosts와 blockedUsers에 없는 문서들만 남기기
                          docs = docs.where((doc) {
                            var postData = doc.data();
                            return !viewModel.reportedPosts.contains(doc.id) &&
                                !viewModel.blockedUsers
                                    .contains(postData.userEmail);
                          }).toList();

                          return PageView.builder(
                            controller: _controller,
                            scrollDirection: Axis.vertical,
                            itemCount: docs.length,

                            // 페이지 변경 시
                            onPageChanged: (index) async {
                              var post = docs[index].data();
                              String audioUrl = post.audioUrl;
                              Provider.of<AudioPlayProvider>(context,
                                      listen: false)
                                  .togglePlay(audioUrl);
                              viewModel.setCurrentDocumentId(docs[index].id);
                            },

                            // 아이템 빌더
                            itemBuilder: (context, index) {
                              var postData = docs[index].data();
                              if (index == 0 &&
                                  viewModel.currentDocumentId == '') {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  viewModel.setCurrentDocumentId(docs[0].id);
                                  print(
                                      '초기 화면의 Doc ID : ${viewModel.currentDocumentId}');
                                });
                              }

                              print(
                                  'CurrentDocument ID : ${viewModel.currentDocumentId}');

                              String audioUrl = postData.audioUrl;
                              String nickname = postData.nickname;
                              String postTitle = postData.postTitle;
                              String profilePicUrl = postData.profilePicUrl;
                              String postUserEmail = postData.userEmail;

                              return PostingCard(
                                audioUrl: audioUrl,
                                profilePicUrl: profilePicUrl,
                                nickname: nickname,
                                postTitle: postTitle,
                                currentDocumentId: viewModel.currentDocumentId,
                                postUserEmail: postUserEmail,
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
