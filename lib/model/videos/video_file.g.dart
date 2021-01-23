// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoFileModel _$VideoFileModelFromJson(Map<String, dynamic> json) {
  return VideoFileModel(
    id: json['id'] as int,
    quantity: json['quantity'] as String,
    file_type: json['file_type'] as String,
    width: json['width'] as int,
    height: json['height'] as int,
    link: json['link'] as String,
  );
}

Map<String, dynamic> _$VideoFileModelToJson(VideoFileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'file_type': instance.file_type,
      'width': instance.width,
      'height': instance.height,
      'link': instance.link,
    };
