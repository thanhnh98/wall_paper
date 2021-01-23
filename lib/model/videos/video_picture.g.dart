// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_picture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoPictureModel _$VideoPictureModelFromJson(Map<String, dynamic> json) {
  return VideoPictureModel(
    id: json['id'] as int,
    picture: json['picture'] as String,
    nr: json['nr'] as int,
  );
}

Map<String, dynamic> _$VideoPictureModelToJson(VideoPictureModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'picture': instance.picture,
      'nr': instance.nr,
    };
