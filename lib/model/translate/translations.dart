import 'package:flutter_app_new/model/translate/text_translate.dart';
import 'package:json_annotation/json_annotation.dart';
part 'translations.g.dart';

@JsonSerializable()
class TranslationsModel{
   TranslationsModel({this.translations, this.word_count, this.character_count});
   List<TextTranslatedModel> translations;
   int word_count;
   int character_count;

   factory TranslationsModel.fromJson(Map<String, dynamic> json) => _$TranslationsModelFromJson(json);
   Map<String, dynamic> toJson() => _$TranslationsModelToJson(this);
}