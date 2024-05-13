class ChatMessageModel {
  String? chatId;
  String? messageId;
  String audioUrl;
  String dateCreated;
  String userEmail;

  ChatMessageModel({
    this.chatId,
    this.messageId,
    required this.audioUrl,
    required this.dateCreated,
    required this.userEmail,
  });

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'messageId': messageId,
      'audioUrl': audioUrl,
      'dateCreated': dateCreated,
      'userEmail': userEmail,
    };
  }
}