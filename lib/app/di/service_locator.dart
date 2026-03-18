import 'package:get_it/get_it.dart';
import 'package:everyones_tone/app/service/firebase_service.dart';
import 'package:everyones_tone/data/remote_datasource/auth_remote_data_source.dart';
import 'package:everyones_tone/data/remote_datasource/chat_remote_data_source.dart';
import 'package:everyones_tone/data/remote_datasource/post_remote_data_source.dart';
import 'package:everyones_tone/data/remote_datasource/reply_remote_data_source.dart';
import 'package:everyones_tone/data/remote_datasource/report_remote_data_source.dart';
import 'package:google_sign_in/google_sign_in.dart';

///
/// 의존성 주입을 위한 enum
///
enum _LocatorItem {
  firebaseService,
  googleSignIn,
  authRepository,
  postRepository,
  reportRepository,
  chatRoomRepository,
  replyRepository,
}

/// GetIt 인스턴스 생성
final getIt = GetIt.instance;

/// 의존성 등록 함수
void setupLocator() {
  for (final item in _LocatorItem.values) {
    _registerItem(item);
  }
}

/// 의존성 등록
void _registerItem(_LocatorItem item) {
  switch (item) {
    case _LocatorItem.firebaseService:
      if (!getIt.isRegistered<FirebaseService>()) {
        getIt.registerLazySingleton<FirebaseService>(
            () => FirebaseService.instance);
      }
      break;
    case _LocatorItem.googleSignIn:
      if (!getIt.isRegistered<GoogleSignIn>()) {
        getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
      }
      break;
    case _LocatorItem.authRepository:
      if (!getIt.isRegistered<AuthRemoteDataSource>()) {
        getIt.registerLazySingleton<AuthRemoteDataSource>(
            () => AuthRemoteDataSource(getIt()));
      }
      break;
    case _LocatorItem.postRepository:
      if (!getIt.isRegistered<PostRemoteDataSource>()) {
        getIt.registerLazySingleton<PostRemoteDataSource>(
            () => PostRemoteDataSource());
      }
      break;
    case _LocatorItem.reportRepository:
      if (!getIt.isRegistered<ReportRemoteDataSource>()) {
        getIt.registerLazySingleton<ReportRemoteDataSource>(
            () => ReportRemoteDataSource());
      }
      break;
    case _LocatorItem.chatRoomRepository:
      if (!getIt.isRegistered<ChatRemoteDataSource>()) {
        getIt.registerLazySingleton<ChatRemoteDataSource>(
            () => ChatRemoteDataSource());
      }
      break;
    case _LocatorItem.replyRepository:
      if (!getIt.isRegistered<ReplyRemoteDataSource>()) {
        getIt.registerLazySingleton<ReplyRemoteDataSource>(
            () => ReplyRemoteDataSource());
      }
      break;
  }
}
