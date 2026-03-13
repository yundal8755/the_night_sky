import 'package:everyones_tone/data/model/user_model.dart';
import 'package:everyones_tone/data/remote_datasource/register_profile_repository.dart';
import 'package:intl/intl.dart';

class RegisterProfileViewModel {
  Future<void> registerUserData({
    required String userEmail,
    required String nickname,
    required String profilePicUrl,
  }) async {
    String dateCreated = DateFormat("MM/dd HH:mm:ss").format(DateTime.now());
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
    // await repository.registerUserDataLocal(userModel);
  }
}
