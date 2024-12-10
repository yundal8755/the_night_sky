// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
    return <String, dynamic>{
      'chatId': chatId,
      'messageId': messageId,
      'audioUrl': audioUrl,
      'dateCreated': dateCreated,
      'userEmail': userEmail,
    };
  }

  ChatMessageModel copyWith({
    String? chatId,
    String? messageId,
    String? audioUrl,
    String? dateCreated,
    String? userEmail,
  }) {
    return ChatMessageModel(
      chatId: chatId ?? this.chatId,
      messageId: messageId ?? this.messageId,
      audioUrl: audioUrl ?? this.audioUrl,
      dateCreated: dateCreated ?? this.dateCreated,
      userEmail: userEmail ?? this.userEmail,
    );
  }

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      chatId: map['chatId'] != null ? map['chatId'] as String : null,
      messageId: map['messageId'] != null ? map['messageId'] as String : null,
      audioUrl: map['audioUrl'] as String,
      dateCreated: map['dateCreated'] as String,
      userEmail: map['userEmail'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessageModel.fromJson(String source) => ChatMessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatMessageModel(chatId: $chatId, messageId: $messageId, audioUrl: $audioUrl, dateCreated: $dateCreated, userEmail: $userEmail)';
  }

  @override
  bool operator ==(covariant ChatMessageModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.chatId == chatId &&
      other.messageId == messageId &&
      other.audioUrl == audioUrl &&
      other.dateCreated == dateCreated &&
      other.userEmail == userEmail;
  }

  @override
  int get hashCode {
    return chatId.hashCode ^
      messageId.hashCode ^
      audioUrl.hashCode ^
      dateCreated.hashCode ^
      userEmail.hashCode;
  }
}
