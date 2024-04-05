import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String nickname;
  final String profilePicUrl;
  final String userEmail;
  final Timestamp dateCreated;

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
      'email': userEmail,
      'dateCreated': dateCreated,
    };
  }
}
