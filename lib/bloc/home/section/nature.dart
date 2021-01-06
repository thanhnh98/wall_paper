import 'package:flutter_app_new/bloc/home/list_image_bloc.dart';

class NatureBloc extends ListImageBloc{
  NatureBloc(): super();

  @override
  String getListImageUrl() {
    return "https://api.pexels.com/v1/search?query=nature&per_page=10";
  }
}