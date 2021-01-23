import 'package:flutter_app_new/model/videos/user.dart';
import 'package:flutter_app_new/model/videos/video_file.dart';
import 'package:flutter_app_new/model/videos/video_picture.dart';
import 'package:json_annotation/json_annotation.dart';
part 'video.g.dart';

@JsonSerializable()
class VideoModel{
  VideoModel({this.id, this.width, this.height, this.url, this.image, this.duration, this.user, this.video_files, this.video_pictures});
  int id;
  int width;
  int height;
  String url;
  String image;
  int duration;
  UserModel user;
  List<VideoFileModel> video_files;
  List<VideoPictureModel> video_pictures;

  factory VideoModel.fromJson(Map<String, dynamic> json) => _$VideoModelFromJson(json);
  Map<String, dynamic> toJson() => _$VideoModelToJson(this);

  VideoModel clone(){
    return VideoModel(
        id: this.id,
        width: this.width,
        height: this.height,
        url: this.url,
        image: this.image,
        duration: this.duration,
        user: this.user,
        video_files: this.video_files,
        video_pictures: this.video_pictures);
  }
}