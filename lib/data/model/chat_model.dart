import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  String? chatId;
  String dateCreated;
  String postTitle;
  String postUserNickname;
  String postUserEmail;
  String postUserProfilePicUrl;
  String replyUserNickname;
  String replyUserEmail;
  String replyUserProfilePicUrl;

  ChatModel({
    this.chatId,
    required this.dateCreated,
    required this.postTitle,
    required this.postUserNickname,
    required this.postUserEmail,
    required this.postUserProfilePicUrl,
    required this.replyUserNickname,
    required this.replyUserEmail,
    required this.replyUserProfilePicUrl,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'dateCreated': dateCreated,
      'postUserNickname': postUserNickname,
      'postUserEmail': postUserEmail,
      'postUserProfilePicUrl': postUserProfilePicUrl,
      'postTitle': postTitle,
      'replyUserNickname': replyUserNickname,
      'replyUserEmail': replyUserEmail,
      'replyUserProfilePicUrl': replyUserProfilePicUrl,
    };
  }
}
