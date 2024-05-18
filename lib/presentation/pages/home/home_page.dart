// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/repository/database_helper.dart';
import 'package:everyones_tone/presentation/widgets/app_bar/main_app_bar.dart';
import 'package:everyones_tone/presentation/widgets/posting_card/full_size_posting_card%20copy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final postCollection = FirebaseFirestore.instance.collection('post');
  String currentDocumentId = '';
  int currentPageIndex = 0;
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final _controller = PageController();

  @override
  void initState() {
    super.initState();
    // FirebaseAuth의 userChanges 스트림을 구독
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

    setState(() {
      // 테이블 조회
      // databaseHelper.fetchTableData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const MainAppBar(title: '홈'),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: postCollection.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

                // 스냅샷에서 문서 데이터 추출
                List<DocumentSnapshot> docs = snapshot.data!.docs;

                return PageView.builder(
                  controller: _controller,
                  scrollDirection: Axis.vertical,
                  itemCount: docs.length,
                  onPageChanged: (index) {
                    // 현재 페이지 인덱스를 사용하여 문서 ID 가져오기
                    String documentId = docs[index].id;

                    // 터미널에 현재 문서 ID 출력
                    print("현재 페이지의 문서 ID: $documentId");

                    // 현재 페이지 인덱스에 따라 상태 업데이트
                    setState(() {
                      currentPageIndex = index; // 페이지 인덱스 업데이트
                      currentDocumentId = docs[index].id; // 문서 ID 업데이트
                    });
                  },
                  itemBuilder: (context, index) {
                    var post = docs[index].data() as Map<String, dynamic>;
                    // 최초 페이지 로드 시 한 번만 실행
                    if (index == 0 && currentPageIndex == 0) {
                      currentDocumentId = docs[0].id;
                    }

                    String audioUrl = post['audioUrl'];
                    String nickname = post['nickname'];
                    String postTitle = post['postTitle'];
                    String profilePicUrl = post['profilePicUrl'];
                    String postUserEmail = post['userEmail'];

                    return FullSizePostingCard(
                      audioUrl: audioUrl,
                      profilePicUrl: profilePicUrl,
                      nickname: nickname,
                      postTitle: postTitle,
                      replyDocmentId: currentDocumentId,
                      postUserEmail: postUserEmail,
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
