// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FCMModel _$FCMModelFromJson(Map<String, dynamic> json) {
  return FCMModel(
    json['notification'] == null
        ? null
        : FCMNotificationModel.fromJson(
            json['notification'] as Map<String, dynamic>),
    json['data'] == null
        ? null
        : FCMDataModel.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FCMModelToJson(FCMModel instance) => <String, dynamic>{
      'notification': instance.notification,
      'data': instance.data,
    };
