// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageModel _$ChatMessageModelFromJson(Map<String, dynamic> json) =>
    ChatMessageModel(
      chatId: json['chatId'] as String?,
      messageId: json['messageId'] as String?,
      audioUrl: json['audioUrl'] as String,
      dateCreated: json['dateCreated'] as String,
      userEmail: json['userEmail'] as String,
    );

Map<String, dynamic> _$ChatMessageModelToJson(ChatMessageModel instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'messageId': instance.messageId,
      'audioUrl': instance.audioUrl,
      'dateCreated': instance.dateCreated,
      'userEmail': instance.userEmail,
    };
