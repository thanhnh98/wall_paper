import 'package:json_annotation/json_annotation.dart';
part 'notification.g.dart';

@JsonSerializable()
class FCMNotificationModel{
    FCMNotificationModel(this.title, this.body);

    String title;
    String body;

  factory FCMNotificationModel.fromJson(Map<String, dynamic> json) => _$FCMNotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$FCMNotificationModelToJson(this);
}