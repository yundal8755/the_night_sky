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

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'profilePicUrl': profilePicUrl,
      'userEmail': userEmail,
      'dateCreated': dateCreated,
    };
  }
}
