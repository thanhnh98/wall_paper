// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) {
  return VideoModel(
    id: json['id'] as int,
    width: json['width'] as int,
    height: json['height'] as int,
    url: json['url'] as String,
    image: json['image'] as String,
    duration: json['duration'] as int,
    user: json['user'] == null
        ? null
        : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    video_files: (json['video_files'] as List)
        ?.map((e) => e == null
            ? null
            : VideoFileModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    video_pictures: (json['video_pictures'] as List)
        ?.map((e) => e == null
            ? null
            : VideoPictureModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'width': instance.width,
      'height': instance.height,
      'url': instance.url,
      'image': instance.image,
      'duration': instance.duration,
      'user': instance.user,
      'video_files': instance.video_files,
      'video_pictures': instance.video_pictures,
    };
