import 'package:everyones_tone/app/constant/app_assets.dart';
import 'package:everyones_tone/app/di/service_locator.dart';
import 'package:everyones_tone/app/service/firebase_service.dart';
import 'package:everyones_tone/data/remote_datasource/post_remote_data_source.dart';
import 'package:flutter/widgets.dart';

///
/// 게시글 뷰모델
///
class PostViewModel extends ChangeNotifier {
  final postRemoteDataSource = getIt<PostRemoteDataSource>();

  final String hintText = '제목을 입력해주세요!';
  final textEditingController = TextEditingController();

  String currentNickname = '';
  String currentProfilePicUrl = AppAssets.profileBasicImage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  /// 입력받은 정보를 Firestore에 업로드
  Future<bool> uploadPost(String localAudioUrl) async {
    if (_isLoading) return false;

    _setLoading(true);

    try {
      final userData = await FirebaseService.fetchCurrentUser();

      if (userData == null) {
        return false;
      }

      final postTitle = textEditingController.text.isEmpty
          ? hintText
          : textEditingController.text;

      final nickname =
          currentNickname.isNotEmpty ? currentNickname : userData.nickname;

      final profilePicUrl = currentProfilePicUrl.isNotEmpty
          ? currentProfilePicUrl
          : userData.profilePicUrl;

      await postRemoteDataSource.uploadPost(
        postTitle: postTitle,
        localAudioUrl: localAudioUrl,
        userEmail: userData.userEmail,
        nickname: nickname,
        profilePicUrl: profilePicUrl,
      );

      return true; // 성공
    } catch (e) {
      // 에러 로깅 또는 예외 처리 (필요시 추가)
      return false; // 실패
    } finally {
      _setLoading(false);
    }
  }

  /// 로딩 상태 변경
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
