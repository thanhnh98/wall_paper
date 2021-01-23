import 'package:flutter_app_new/model/photo.dart';
import 'package:flutter_app_new/model/videos/video.dart';
import 'package:json_annotation/json_annotation.dart';
part 'album.g.dart';

@JsonSerializable()
class AlbumModel{

  AlbumModel({this.page, this.per_page, this.photos, this.videos, this.url, this.total_results, this.next_page});

  int page;
  int per_page;
  List<Photo> photos;
  List<VideoModel> videos;
  String url;
  int total_results;
  String next_page;

  factory AlbumModel.fromJson(Map<String, dynamic> json) => _$AlbumModelFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumModelToJson(this);

  AlbumModel clone(){
    return AlbumModel(
        page: this.page,
        per_page: this.per_page,
        photos: this.photos,
        videos: this.videos,
        url: this.url,
        total_results: this.total_results,
        next_page: this.next_page);
  }
}