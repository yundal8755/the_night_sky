// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      postTitle: json['postTitle'] as String,
      audioUrl: json['audioUrl'] as String,
      userEmail: json['userEmail'] as String,
      nickname: json['nickname'] as String,
      profilePicUrl: json['profilePicUrl'] as String,
      dateCreated: json['dateCreated'] as String,
      boardName: json['boardName'] as String,
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'postTitle': instance.postTitle,
      'audioUrl': instance.audioUrl,
      'userEmail': instance.userEmail,
      'nickname': instance.nickname,
      'profilePicUrl': instance.profilePicUrl,
      'dateCreated': instance.dateCreated,
      'boardName': instance.boardName,
    };
