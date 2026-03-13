// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/repository/firestore_data.dart';

class ReportRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //! 게시글 신고하기
  Future<void> reportPosts(String reportedChatId) async {
    // 현재 유저의 문서 참조 가져오기
    final DocumentReference currentUserRef =
        firestore.collection('user').doc(FirestoreData.currentUserEmail);

    // SubCollection에 reportedPosts 문서와 reportedChatId 필드 값 추가하기
    await currentUserRef
        .collection('reported')
        .doc('reportedPosts')
        .set({
          'reportedChatId': FieldValue.arrayUnion([reportedChatId])
        }, SetOptions(merge: true));

    print('reportPosts 정상적으로 실행!');
  }

  //! 사용자 차단하기
  Future<void> blockUsers(String blockedUserEmail) async {
    // 현재 유저의 문서 참조 가져오기
    DocumentReference currentUserRef =
        firestore.collection('user').doc(FirestoreData.currentUserEmail);

    // reported SubCollection에 blockedUsers 문서와 blockedUserEmail 필드 값 추가하기
    await currentUserRef
        .collection('reported')
        .doc('blockedUsers')
        .set({
          'blockedUserEmail': FieldValue.arrayUnion([blockedUserEmail])
        }, SetOptions(merge: true));

    print('BlockUsers 정상적으로 실행!');
  }

  //! 관리자 페이지에 목록 추가하기
  Future<void> countReportedPosts(String reportedChatId) async {
    final DocumentReference reportRef =
        firestore.collection('report').doc('reportedPosts');

    // 현재 값을 가져오기
    final DocumentSnapshot snapshot = await reportRef.get();
    int reportCounted = 0;

    if (snapshot.exists && snapshot.data() != null) {
      var data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey(reportedChatId)) {
        reportCounted = int.parse(data[reportedChatId]);
      }
    }

    // 값을 1 증가시키기
    await reportRef
        .set({reportedChatId: '${reportCounted + 1}'}, SetOptions(merge: true));
  }
}
