import 'package:json_annotation/json_annotation.dart';
part 'video_picture.g.dart';

@JsonSerializable()
class VideoPictureModel{
  int id;
  String picture;
  int nr;

  VideoPictureModel({this.id, this.picture, this.nr});

  factory VideoPictureModel.fromJson(Map<String, dynamic> json) => _$VideoPictureModelFromJson(json);
  Map<String, dynamic> toJson() => _$VideoPictureModelToJson(this);
}