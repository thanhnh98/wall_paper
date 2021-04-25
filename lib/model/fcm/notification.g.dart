// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FCMNotificationModel _$FCMNotificationModelFromJson(Map<String, dynamic> json) {
  return FCMNotificationModel(
    json['title'] as String,
    json['body'] as String,
  );
}

Map<String, dynamic> _$FCMNotificationModelToJson(
        FCMNotificationModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
    };
