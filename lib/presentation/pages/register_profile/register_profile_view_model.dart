import 'package:everyones_tone/app/models/user_model.dart';
import 'package:everyones_tone/presentation/pages/register_profile/register_profile_repository.dart';
import 'package:intl/intl.dart';

class RegisterProfileViewModel {
  Future<void> registerUserData({
    required String userEmail,
    required String nickname,
    required String profilePicUrl,
  }) async {
    String dateCreated = DateFormat("yyyy'년' MM'월' dd'일' HH'시' mm'분' ss'초'")
        .format(DateTime.now());

    // UserData 모델링
    UserModel userModel = UserModel(
      nickname: nickname,
      profilePicUrl: profilePicUrl,
      userEmail: userEmail,
      dateCreated: dateCreated,
    );

    // Repository Instance 생성
    RegisterProfileRepository repository = RegisterProfileRepository();

    // Repository에 Model Instance 전달
    await repository.registerUserDataRemote(userModel);
    await repository.registerUserDataLocal(userModel);
  }
}
