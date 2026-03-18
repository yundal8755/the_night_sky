import 'package:everyones_tone/data/model/user_model.dart';
import 'package:everyones_tone/app/di/service_locator.dart';
import 'package:everyones_tone/data/remote_datasource/auth_remote_data_source.dart';
import 'package:intl/intl.dart';

class RegisterProfileViewModel {
  RegisterProfileViewModel({
    AuthRemoteDataSource? authRemoteDataSource,
  }) : _authRemoteDataSource =
            authRemoteDataSource ?? getIt<AuthRemoteDataSource>();

  final AuthRemoteDataSource _authRemoteDataSource;

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

    await _authRemoteDataSource.registerUserDataRemote(userModel);
    // await repository.registerUserDataLocal(userModel);
  }
}
