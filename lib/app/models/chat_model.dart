// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
  int? fetchMessageCount;

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
    this.fetchMessageCount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatId': chatId,
      'dateCreated': dateCreated,
      'postTitle': postTitle,
      'postUserNickname': postUserNickname,
      'postUserEmail': postUserEmail,
      'postUserProfilePicUrl': postUserProfilePicUrl,
      'replyUserNickname': replyUserNickname,
      'replyUserEmail': replyUserEmail,
      'replyUserProfilePicUrl': replyUserProfilePicUrl,
      'fetchMessageCount': fetchMessageCount,
    };
  }

  ChatModel copyWith({
    String? chatId,
    String? dateCreated,
    String? postTitle,
    String? postUserNickname,
    String? postUserEmail,
    String? postUserProfilePicUrl,
    String? replyUserNickname,
    String? replyUserEmail,
    String? replyUserProfilePicUrl,
    int? fetchMessageCount,
  }) {
    return ChatModel(
      chatId: chatId ?? this.chatId,
      dateCreated: dateCreated ?? this.dateCreated,
      postTitle: postTitle ?? this.postTitle,
      postUserNickname: postUserNickname ?? this.postUserNickname,
      postUserEmail: postUserEmail ?? this.postUserEmail,
      postUserProfilePicUrl: postUserProfilePicUrl ?? this.postUserProfilePicUrl,
      replyUserNickname: replyUserNickname ?? this.replyUserNickname,
      replyUserEmail: replyUserEmail ?? this.replyUserEmail,
      replyUserProfilePicUrl: replyUserProfilePicUrl ?? this.replyUserProfilePicUrl,
      fetchMessageCount: fetchMessageCount ?? this.fetchMessageCount,
    );
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatId: map['chatId'] != null ? map['chatId'] as String : null,
      dateCreated: map['dateCreated'] as String,
      postTitle: map['postTitle'] as String,
      postUserNickname: map['postUserNickname'] as String,
      postUserEmail: map['postUserEmail'] as String,
      postUserProfilePicUrl: map['postUserProfilePicUrl'] as String,
      replyUserNickname: map['replyUserNickname'] as String,
      replyUserEmail: map['replyUserEmail'] as String,
      replyUserProfilePicUrl: map['replyUserProfilePicUrl'] as String,
      fetchMessageCount: map['fetchMessageCount'] != null ? map['fetchMessageCount'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(chatId: $chatId, dateCreated: $dateCreated, postTitle: $postTitle, postUserNickname: $postUserNickname, postUserEmail: $postUserEmail, postUserProfilePicUrl: $postUserProfilePicUrl, replyUserNickname: $replyUserNickname, replyUserEmail: $replyUserEmail, replyUserProfilePicUrl: $replyUserProfilePicUrl, fetchMessageCount: $fetchMessageCount)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.chatId == chatId &&
      other.dateCreated == dateCreated &&
      other.postTitle == postTitle &&
      other.postUserNickname == postUserNickname &&
      other.postUserEmail == postUserEmail &&
      other.postUserProfilePicUrl == postUserProfilePicUrl &&
      other.replyUserNickname == replyUserNickname &&
      other.replyUserEmail == replyUserEmail &&
      other.replyUserProfilePicUrl == replyUserProfilePicUrl &&
      other.fetchMessageCount == fetchMessageCount;
  }

  @override
  int get hashCode {
    return chatId.hashCode ^
      dateCreated.hashCode ^
      postTitle.hashCode ^
      postUserNickname.hashCode ^
      postUserEmail.hashCode ^
      postUserProfilePicUrl.hashCode ^
      replyUserNickname.hashCode ^
      replyUserEmail.hashCode ^
      replyUserProfilePicUrl.hashCode ^
      fetchMessageCount.hashCode;
  }
}
