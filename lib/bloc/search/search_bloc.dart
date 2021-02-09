import 'dart:async';

import 'package:flutter_app_new/repository/translate_repository.dart';

class SearchBloc{
  static int _perpage = 80;

  StreamController<String> _searchContentStream;

  SearchBloc(){
    _searchContentStream = StreamController();
  }

  Future<void> handleSearch(String content) async{
    // String contentTranslated = await TranslateRepository().getTextTranslated(content);
    // print("content = $contentTranslated");
    _searchContentStream.add(_getUrlSearchWithContent(content));
  }

  String _getUrlSearchWithContent(String content){
    return "https://api.pexels.com/v1/search?query=$content&per_page=$_perpage";
  }

  Stream getContentSearch() => _searchContentStream.stream;

}