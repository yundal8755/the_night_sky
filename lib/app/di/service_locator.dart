import 'package:get_it/get_it.dart';
import 'package:everyones_tone/presentation/pages/chat_room/chat_room_view_model.dart';

// GetIt 인스턴스 생성
final getIt = GetIt.instance;

// 의존성 등록 함수
void setupLocator() {
  getIt.registerLazySingleton<ChatRoomViewModel>(() => ChatRoomViewModel());
}
