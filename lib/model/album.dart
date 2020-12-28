import 'package:flutter_app_new/model/photo.dart';
import 'package:json_annotation/json_annotation.dart';
part 'album.g.dart';

@JsonSerializable()
class AlbumModel{

  AlbumModel();

  int page;
  int per_page;
  List<Photo> photos;
  int total_results;
  String next_page;

  factory AlbumModel.fromJson(Map<String, dynamic> json) => _$AlbumModelFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumModelToJson(this);
}