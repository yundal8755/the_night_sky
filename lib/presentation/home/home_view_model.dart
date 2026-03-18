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

  Future<void> init() async {
    await loadReportedPosts();
    await loadBlockedUsers();
    _listenAuthChanges();
  }

  Future<void> loadReportedPosts() async {
    reportedPosts = await reportRemoteDataSource.fetchReportedPosts();
    notifyListeners();
  }

  Future<void> loadBlockedUsers() async {
    blockedUsers = await reportRemoteDataSource.fetchBlockedUsers();
    notifyListeners();
  }

  void setCurrentDocumentId(String documentId) {
    currentDocumentId = documentId;
    notifyListeners();
  }

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
