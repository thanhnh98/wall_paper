// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationsModel _$TranslationsModelFromJson(Map<String, dynamic> json) {
  return TranslationsModel(
    translations: (json['translations'] as List)
        ?.map((e) => e == null
            ? null
            : TextTranslatedModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    word_count: json['word_count'] as int,
    character_count: json['character_count'] as int,
  );
}

Map<String, dynamic> _$TranslationsModelToJson(TranslationsModel instance) =>
    <String, dynamic>{
      'translations': instance.translations,
      'word_count': instance.word_count,
      'character_count': instance.character_count,
    };
