import 'package:flutter_app_new/model/fcm/data.dart';
import 'package:flutter_app_new/model/fcm/notification.dart';
import 'package:json_annotation/json_annotation.dart';
part 'fcm.g.dart';

@JsonSerializable()
class FCMModel{
  FCMModel(this.notification, this.data);

  FCMNotificationModel notification;
  FCMDataModel data;

  factory FCMModel.fromJson(Map<String, dynamic> json) => _$FCMModelFromJson(json);
  Map<String, dynamic> toJson() => _$FCMModelToJson(this);
}