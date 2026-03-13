// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) => ChatModel(
      chatId: json['chatId'] as String?,
      dateCreated: json['dateCreated'] as String,
      postTitle: json['postTitle'] as String,
      postUserNickname: json['postUserNickname'] as String,
      postUserEmail: json['postUserEmail'] as String,
      postUserProfilePicUrl: json['postUserProfilePicUrl'] as String,
      replyUserNickname: json['replyUserNickname'] as String,
      replyUserEmail: json['replyUserEmail'] as String,
      replyUserProfilePicUrl: json['replyUserProfilePicUrl'] as String,
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'chatId': instance.chatId,
      'dateCreated': instance.dateCreated,
      'postTitle': instance.postTitle,
      'postUserNickname': instance.postUserNickname,
      'postUserEmail': instance.postUserEmail,
      'postUserProfilePicUrl': instance.postUserProfilePicUrl,
      'replyUserNickname': instance.replyUserNickname,
      'replyUserEmail': instance.replyUserEmail,
      'replyUserProfilePicUrl': instance.replyUserProfilePicUrl,
    };
