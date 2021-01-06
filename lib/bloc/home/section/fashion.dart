import 'package:flutter_app_new/bloc/home/list_image_bloc.dart';

class FashionBloc extends ListImageBloc{
  @override
  String getListImageUrl() {
    return "https://api.pexels.com/v1/search?query=fashion&per_page=7";
  }

}