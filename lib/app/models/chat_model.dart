class ChatModel {
  String? chatId;
  String currentUserNickname;
  String currentUserEmail;
  String currentUserProfilePicUrl;
  String dateCreated;
  String partnerUserNickname;
  String partnerUserEmail;
  String partnerUserProfilePicUrl;
  String postTitle;
  String postUserNickname;
  String postUserEmail;
  String postUserProfilePicUrl;
  String replyUserNickname;
  String replyUserEmail;
  String replyUserProfilePicUrl;

  ChatModel({
    this.chatId,
    required this.currentUserNickname,
    required this.currentUserEmail,
    required this.currentUserProfilePicUrl,
    required this.dateCreated,
    required this.partnerUserNickname,
    required this.partnerUserEmail,
    required this.partnerUserProfilePicUrl,
    required this.postTitle,
    required this.postUserNickname,
    required this.postUserEmail,
    required this.postUserProfilePicUrl,
    required this.replyUserNickname,
    required this.replyUserEmail,
    required this.replyUserProfilePicUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'currentUserNickname': currentUserNickname,
      'currentUserEmail': currentUserEmail,
      'currentUserProfilePicUrl': currentUserProfilePicUrl,
      'dateCreated': dateCreated,
      'partnerUserNickname': partnerUserNickname,
      'partnerUserEmail': partnerUserEmail,
      'partnerUserProfilePicUrl': partnerUserProfilePicUrl,
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
