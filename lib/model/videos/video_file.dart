import 'package:json_annotation/json_annotation.dart';
part 'video_file.g.dart';

@JsonSerializable()
class VideoFileModel{
  int id;
  String quantity;
  String file_type;
  int width;
  int height;
  String link;

  VideoFileModel({this.id, this.quantity, this.file_type, this.width, this.height, this.link});

  factory VideoFileModel.fromJson(Map<String, dynamic> json) => _$VideoFileModelFromJson(json);
  Map<String, dynamic> toJson() => _$VideoFileModelToJson(this);

}