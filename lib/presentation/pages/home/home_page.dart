import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/presentation/widgets/main_app_bar.dart';
import 'package:everyones_tone/presentation/widgets/posting_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final postCollection = FirebaseFirestore.instance.collection('post');

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: MainAppBar(title: '홈'),
      body: SafeArea(
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

            // 스냅샷에서 문서 데이터를 추출
            List<DocumentSnapshot> docs = snapshot.data!.docs;

            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: docs.length,
              itemBuilder: (context, index) {
                var post = docs[index].data() as Map<String, dynamic>;
                String audioUrl = post['audioUrl'];
                String nickname = post['nickname'];
                String postTitle = post['postTitle'];
                String profilePicUrl = post['profilePicUrl'];

                return Center(
                    child: PostingCard(
                  audioUrl: audioUrl,
                  profilePicUrl: profilePicUrl,
                  nickname: nickname,
                  postTitle: postTitle,
                ));
              },
            );
          },
        ),
      ),
    );
  }
}
