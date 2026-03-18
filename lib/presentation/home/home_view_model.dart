import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/di/service_locator.dart';
import 'package:everyones_tone/data/model/post_model.dart';
import 'package:everyones_tone/data/remote_datasource/auth_remote_data_source.dart';
import 'package:everyones_tone/data/remote_datasource/post_remote_data_source.dart';
import 'package:everyones_tone/data/remote_datasource/report_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel extends ChangeNotifier {
  final postRemoteDataSource = getIt<PostRemoteDataSource>();
  final reportRemoteDataSource = getIt<ReportRemoteDataSource>();
  final authRemoteDataSource = getIt<AuthRemoteDataSource>();

  List<String> reportedPosts = [];
  List<String> blockedUsers = [];
  String currentDocumentId = '';

  StreamSubscription<User?>? _authSubscription;

  Stream<QuerySnapshot<PostModel>> get postsStream =>
      postRemoteDataSource.postsStream();

  /// 초기화
  Future<void> init() async {
    await loadReportedPosts();
    await loadBlockedUsers();
    _listenAuthChanges();
  }

  /// 신고된 게시글 불러오기
  Future<void> loadReportedPosts() async {
    reportedPosts = await reportRemoteDataSource.fetchReportedPosts();
    notifyListeners();
  }

  /// 차단된 유저 불러오기
  Future<void> loadBlockedUsers() async {
    blockedUsers = await reportRemoteDataSource.fetchBlockedUsers();
    notifyListeners();
  }

  /// 현재 보고 있는 게시글의 문서 ID 설정
  void setCurrentDocumentId(String documentId) {
    currentDocumentId = documentId;
    notifyListeners();
  }

  /// 로그인 상태 변경 감지
  void _listenAuthChanges() {
    _authSubscription?.cancel();
    _authSubscription = authRemoteDataSource.userChanges().listen(
      (User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
        }
      },
    );
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
