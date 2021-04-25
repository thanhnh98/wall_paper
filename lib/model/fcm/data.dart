
import 'package:json_annotation/json_annotation.dart';
part 'data.g.dart';

@JsonSerializable()
class FCMDataModel{
  FCMDataModel(this.message);

  String message;

  factory FCMDataModel.fromJson(Map<String, dynamic> json) => _$FCMDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$FCMDataModelToJson(this);
}