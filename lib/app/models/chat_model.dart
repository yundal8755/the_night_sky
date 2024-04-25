class ChatModel {
  String? chatId;
  String postUserNickname;
  String postUserEmail;
  String postUserProfilePicUrl;
  String postTitle;
  String replyUserNickname;
  String replyUserEmail;
  String replyUserProfilePicUrl;
  String dateCreated;

  ChatModel({
    this.chatId,
    required this.postUserNickname,
    required this.postUserEmail,
    required this.postUserProfilePicUrl,
    required this.postTitle,
    required this.replyUserNickname,
    required this.replyUserEmail,
    required this.replyUserProfilePicUrl,
    required this.dateCreated,
  });

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'postUserNickname': postUserNickname,
      'postUserEmail': postUserEmail,
      'postUserProfilePicUrl': postUserProfilePicUrl,
      'postTitle': postTitle,
      'replyUserNickname': replyUserNickname,
      'replyUserEmail': replyUserEmail,
      'replyUserProfilePicUrl': replyUserProfilePicUrl,
      'dateCreated': dateCreated,
    };
  }
}
