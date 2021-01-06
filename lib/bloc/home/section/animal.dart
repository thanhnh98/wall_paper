import 'package:flutter_app_new/bloc/home/list_image_bloc.dart';
import 'package:flutter_app_new/bloc/home/list_image_loading_event.dart';

class AnimalBloc extends ListImageBloc{
  AnimalBloc() : super();

  @override
  String getListImageUrl() {
    return "https://api.pexels.com/v1/search?query=animal&per_page=7";
  }

}