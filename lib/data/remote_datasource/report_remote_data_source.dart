// ignore_for_file: avoid_print

import 'package:everyones_tone/app/di/service_locator.dart';
import 'package:everyones_tone/app/service/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///
/// 신고 관련 원격 데이터 소스
///
class ReportRemoteDataSource {
  ReportRemoteDataSource();

  final firebaseService = getIt<FirebaseService>();

  FirebaseFirestore get firestore => firebaseService.firestoreInstance;

  /// 게시글 신고하기
  Future<void> reportPosts(String reportedChatId) async {
    final currentUserEmail = firebaseService.currentUserEmailValue;
    if (currentUserEmail == null) {
      return;
    }
    // 현재 유저의 문서 참조 가져오기
    final DocumentReference currentUserRef = firestore
        .collection(FirestoreCollection.user.name)
        .doc(currentUserEmail);

    // SubCollection에 reportedPosts 문서와 reportedChatId 필드 값 추가하기
    await currentUserRef
        .collection(FirestoreSubCollection.reported.name)
        .doc(FirestoreSubCollection.reportedPosts.name)
        .set({
      'reportedChatId': FieldValue.arrayUnion([reportedChatId])
    }, SetOptions(merge: true));

    print('reportPosts 정상적으로 실행!');
  }

  /// 사용자 차단하기
  Future<void> blockUsers(String blockedUserEmail) async {
    final currentUserEmail = firebaseService.currentUserEmailValue;
    if (currentUserEmail == null) {
      return;
    }
    // 현재 유저의 문서 참조 가져오기
    DocumentReference currentUserRef = firestore
        .collection(FirestoreCollection.user.name)
        .doc(currentUserEmail);

    // reported SubCollection에 blockedUsers 문서와 blockedUserEmail 필드 값 추가하기
    await currentUserRef
        .collection(FirestoreSubCollection.reported.name)
        .doc(FirestoreSubCollection.blockedUsers.name)
        .set({
      'blockedUserEmail': FieldValue.arrayUnion([blockedUserEmail])
    }, SetOptions(merge: true));

    print('BlockUsers 정상적으로 실행!');
  }

  /// 관리자 페이지에 목록 추가하기
  Future<void> countReportedPosts(String reportedChatId) async {
    final DocumentReference reportRef = firestore
        .collection(FirestoreCollection.report.name)
        .doc(FirestoreSubCollection.reportedPosts.name);

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

  /// 신고된 게시글 목록 가져오기
  Future<List<String>> fetchReportedPosts() async {
    final currentUserEmail = firebaseService.currentUserEmailValue;
    if (currentUserEmail == null) {
      return [];
    }
    final userDoc = firestore
        .collection(FirestoreCollection.user.name)
        .doc(currentUserEmail);
    final reportedCollection =
        userDoc.collection(FirestoreSubCollection.reported.name);
    final snapshot = await reportedCollection
        .doc(FirestoreSubCollection.reportedPosts.name)
        .get();

    if (!snapshot.exists) {
      return [];
    }
    final data = snapshot.data();
    if (data == null) {
      return [];
    }
    if (data['reportedChatId'] is Iterable) {
      return List<String>.from(data['reportedChatId']);
    }
    if (data['reportedChatId'] is String) {
      return [data['reportedChatId']];
    }
    return [];
  }

  /// 차단 사용자 목록 가져오기
  Future<List<String>> fetchBlockedUsers() async {
    final currentUserEmail = firebaseService.currentUserEmailValue;
    if (currentUserEmail == null) {
      return [];
    }
    final userDoc = firestore
        .collection(FirestoreCollection.user.name)
        .doc(currentUserEmail);
    final reportedCollection =
        userDoc.collection(FirestoreSubCollection.reported.name);
    final snapshot = await reportedCollection
        .doc(FirestoreSubCollection.blockedUsers.name)
        .get();

    if (!snapshot.exists) {
      return [];
    }
    final data = snapshot.data();
    if (data == null) {
      return [];
    }
    if (data['blockedUserEmail'] is Iterable) {
      return List<String>.from(data['blockedUserEmail']);
    }
    if (data['blockedUserEmail'] is String) {
      return [data['blockedUserEmail']];
    }
    return [];
  }
}
