// ignore_for_file: avoid_print

import 'package:everyones_tone/app/di/service_locator.dart';
import 'package:everyones_tone/data/remote_datasource/reply_remote_data_source.dart';
import 'package:everyones_tone/data/model/user_model.dart';

class ReplyViewModel {
  ReplyViewModel({
    ReplyRemoteDataSource? replyRepository,
  }) : replyRemoteRepository =
            replyRepository ?? getIt<ReplyRemoteDataSource>();

  final ReplyRemoteDataSource replyRemoteRepository;

  //! 입력받은 정보를 DB에 업로드
  Future<void> uploadReply(
      {required String localAudioUrl,
      required UserModel replyUser,
      required String replyDocumentId}) async {
    await replyRemoteRepository.uploadReply(
      localAudioUrl: localAudioUrl,
      replyUser: replyUser,
      replyDocumentId: replyDocumentId,
    );
  }
}
