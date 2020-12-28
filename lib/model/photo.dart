
import 'package:flutter_app_new/model/photo_src.dart';
import 'package:json_annotation/json_annotation.dart';
part 'photo.g.dart';

@JsonSerializable()
class Photo{

  Photo();
  int id;
  int width;
  int height;
  String url;
  String photographer;
  String photographer_url;
  int photographer_id;
  String avg_color;
  PhotoSource src;
  bool liked;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoToJson(this);

}