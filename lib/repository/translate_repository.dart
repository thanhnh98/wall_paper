import 'dart:convert';

import 'package:flutter_app_new/common/network/network.dart';
import 'package:flutter_app_new/common/network/translate_network.dart';
import 'package:flutter_app_new/model/translate/translations.dart';

class TranslateRepository extends TranslateNetwork{
    Future<TranslationsModel> _translate(String text, String from, String to) async {
      final response = await post(text, from, to);

      if(response.statusCode == 200) {
        return TranslationsModel.fromJson(json.decode(response.body));
      }
      else{
        throw Exception(response.statusCode);
      }
    }

    Future<String> getTextTranslated(String text) async{
      TranslationsModel translation = await TranslateRepository()._translate(text, "vi", "en");
      String textTranslated = translation?.translations[0]?.translation??"";
      return textTranslated;
    }
}