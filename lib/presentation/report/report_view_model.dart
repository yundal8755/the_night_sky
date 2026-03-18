// ignore_for_file: avoid_print

import 'package:everyones_tone/app/di/service_locator.dart';
import 'package:everyones_tone/data/remote_datasource/report_remote_data_source.dart';
import 'package:flutter/material.dart';

///
/// 신고하기, 차단하기 기능을 담당하는 뷰모델
///
class ReportViewModel with ChangeNotifier {
  final ReportRemoteDataSource reportRemoteDataSource =
      getIt<ReportRemoteDataSource>();

  //! 게시글 신고하기
  Future<void> reportPosts({required String reportedChatId}) async {
    print('ReportViewModel - reportPosts 정상적으로 실행!');
    print('reportedChatId : $reportedChatId');

    await reportRemoteDataSource.reportPosts(reportedChatId);
    await reportRemoteDataSource.countReportedPosts(reportedChatId);
  }

  //! 사용자 차단하기
  Future<void> blockUsers({required String blockedUserEmail}) async {
    print('ReportViewModel - blockUsers 정상적으로 실행!');
    print('blockedUserEmail : $blockedUserEmail');

    await reportRemoteDataSource.blockUsers(blockedUserEmail);
  }
}
