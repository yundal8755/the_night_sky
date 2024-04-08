import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String postTitle;
  final String audioUrl;
  final String userEmail;
  final String nickname;
  final String profilePicUrl;
  final Timestamp dateCreated;

  PostModel({
    required this.postTitle,
    required this.audioUrl,
    required this.userEmail,
    required this.nickname,
    required this.profilePicUrl,
    required this.dateCreated,
  });

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'audioUrl': audioUrl,
      'profilePicUrl': profilePicUrl,
      'userEmail': userEmail,
      'postTitle': postTitle,
      'dateCreated': dateCreated,
    };
  }
}
