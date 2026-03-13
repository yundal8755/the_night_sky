// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      nickname: json['nickname'] as String,
      profilePicUrl: json['profilePicUrl'] as String,
      userEmail: json['userEmail'] as String,
      dateCreated: json['dateCreated'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'nickname': instance.nickname,
      'profilePicUrl': instance.profilePicUrl,
      'userEmail': instance.userEmail,
      'dateCreated': instance.dateCreated,
    };
