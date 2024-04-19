import 'package:cloud_firestore/cloud_firestore.dart';

class ReplyModel {
  final String audioUrl;
  final String userEmail;
  final String nickname;
  final String profilePicUrl;
  final Timestamp dateCreated;
  final String replyDocmentId;

  ReplyModel({
    required this.audioUrl,
    required this.userEmail,
    required this.nickname,
    required this.profilePicUrl,
    required this.dateCreated,
    required this.replyDocmentId
  });

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'audioUrl': audioUrl,
      'profilePicUrl': profilePicUrl,
      'userEmail': userEmail,
      'dateCreated': dateCreated,
      'replyDocmentId': replyDocmentId
    };
  }
}
