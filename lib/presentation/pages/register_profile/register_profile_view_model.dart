import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/models/user_model.dart';
import 'package:everyones_tone/presentation/pages/register_profile/register_profile_remote_repository.dart';

class RegisterProfileViewModel {

  //! 모델링 후 Remote Repository로 보내기
  Future<void> registerUserData({
    required String userEmail,
    required String nickname,
    required String profilePicUrl,
  }) async {
    Timestamp dateCreated = Timestamp.fromDate(DateTime.now());

    // UserData 모델링
    UserModel userModel = UserModel(
      nickname: nickname,
      profilePicUrl: profilePicUrl,
      userEmail: userEmail,
      dateCreated: dateCreated,
    );

    await RegisterProfileRemoteRepository().registerUserData(userModel);
  }
}
