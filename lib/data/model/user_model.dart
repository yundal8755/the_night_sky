import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String nickname;
  final String profilePicUrl;
  final String userEmail;
  final String dateCreated;

  UserModel({
    required this.nickname,
    required this.profilePicUrl,
    required this.userEmail,
    required this.dateCreated,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'profilePicUrl': profilePicUrl,
      'userEmail': userEmail,
      'dateCreated': dateCreated,
    };
  }
}
