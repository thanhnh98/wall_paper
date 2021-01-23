
import 'package:json_annotation/json_annotation.dart';
part 'text_translate.g.dart';

@JsonSerializable()
class TextTranslatedModel{
    TextTranslatedModel({this.translation});
    String translation;

    factory TextTranslatedModel.fromJson(Map<String, dynamic> json) => _$TextTranslatedModelFromJson(json);
    Map<String, dynamic> toJson() => _$TextTranslatedModelToJson(this);
}