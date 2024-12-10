// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/repository/firestore_data.dart';
import 'package:everyones_tone/app/utils/audio_play_provider.dart';
import 'package:everyones_tone/presentation/widgets/app_bar/main_app_bar.dart';
import 'package:everyones_tone/presentation/widgets/posting_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final postCollection = FirebaseFirestore.instance
      .collection('post')
      .orderBy('dateCreated', descending: true);
  String currentDocumentId = '';
  int currentPageIndex = 0;
  final _controller = PageController();
  List<String> reportedPosts = [];
  List<String> blockedUsers = [];

  @override
  void initState() {
    super.initState();
    _loadReportedPosts();
    _loadBlockedUsers();
    FirebaseAuth.instance.userChanges().listen(
      (User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
        }
      },
    );
  }

  Future<void> _loadReportedPosts() async {
    final userDoc = FirebaseFirestore.instance
        .collection('user')
        .doc(FirestoreData.currentUserEmail);
    final reportedCollection = userDoc.collection('reported');
    final snapshot = await reportedCollection.doc('reportedPosts').get();

    setState(() {
      if (snapshot.exists) {
        var data = snapshot.data();
        if (data != null && data['reportedChatId'] is Iterable) {
          reportedPosts = List<String>.from(data['reportedChatId']);
        } else if (data != null && data['reportedChatId'] is String) {
          reportedPosts = [data['reportedChatId']];
        }
      }
    });
  }

  Future<void> _loadBlockedUsers() async {
    final userDoc = FirebaseFirestore.instance
        .collection('user')
        .doc(FirestoreData.currentUserEmail);
    final reportedCollection = userDoc.collection('reported');
    final snapshot = await reportedCollection.doc('blockedUsers').get();

    setState(() {
      if (snapshot.exists) {
        var data = snapshot.data();
        if (data != null && data['blockedUserEmail'] is Iterable) {
          blockedUsers = List<String>.from(data['blockedUserEmail']);
        } else if (data != null && data['blockedUserEmail'] is String) {
          blockedUsers = [data['blockedUserEmail']];
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              const MainAppBar(title: '밤하늘'),
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
                    List<DocumentSnapshot> docs = snapshot.data!.docs;

                    // 필터링: reportedPosts와 blockedUsers에 없는 문서들만 남기기
                    docs = docs.where((doc) {
                      var postData = doc.data() as Map<String, dynamic>;
                      return !reportedPosts.contains(doc.id) &&
                          !blockedUsers.contains(postData['userEmail']);
                    }).toList();

                    return PageView.builder(
                      controller: _controller,
                      scrollDirection: Axis.vertical,
                      itemCount: docs.length,

                      // 페이지 변경 시
                      onPageChanged: (index) async {
                        var post = docs[index].data() as Map<String, dynamic>;
                        String audioUrl = post['audioUrl'];
                        Provider.of<AudioPlayProvider>(context, listen: false)
                            .togglePlay(audioUrl);
                        setState(() {
                          currentDocumentId = docs[index].id;
                        });
                      },

                      // 아이템 빌더
                      itemBuilder: (context, index) {
                        var postData =
                            docs[index].data() as Map<String, dynamic>;
                        if (index == 0 && currentDocumentId == '') {
                          currentDocumentId = docs[0].id;
                          print('초기 화면의 Doc ID : $currentDocumentId');
                        }

                        print('CurrentDocument ID : $currentDocumentId');

                        String audioUrl = postData['audioUrl'];
                        String nickname = postData['nickname'];
                        String postTitle = postData['postTitle'];
                        String profilePicUrl = postData['profilePicUrl'];
                        String postUserEmail = postData['userEmail'];

                        return PostingCard(
                          audioUrl: audioUrl,
                          profilePicUrl: profilePicUrl,
                          nickname: nickname,
                          postTitle: postTitle,
                          currentDocumentId: currentDocumentId,
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
  }
}
