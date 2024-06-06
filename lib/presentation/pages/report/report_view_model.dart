// ignore_for_file: avoid_print

import 'package:everyones_tone/presentation/pages/report/report_repository.dart';

class ReportViewModel {
  ReportRepository reportRepository = ReportRepository();

  //! 게시글 신고하기
  Future<void> reportPosts({required String reportedChatId}) async {
    print('ReportViewModel - reportPosts 정상적으로 실행!');
    print('reportedChatId : $reportedChatId');

    await reportRepository.reportPosts(reportedChatId);
    await reportRepository.countReportedPosts(reportedChatId);
  }

  //! 사용자 차단하기
  Future<void> blockUsers({required String blockedUserEmail}) async {
    print('ReportViewModel - blockUsers 정상적으로 실행!');
    print('blockedUserEmail : $blockedUserEmail');

    await reportRepository.blockUsers(blockedUserEmail);
  }
}
