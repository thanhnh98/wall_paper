import 'package:bloc/bloc.dart';
import 'package:flutter_app_new/bloc/home/list_image_loading_event.dart';
import 'package:flutter_app_new/model/photo.dart';
import 'package:flutter_app_new/repository/image_landing_repository.dart';

abstract class ListImageBloc extends Bloc<ListImageLoadingEvent, List<Photo>>{
  ListImageBloc() : super(null){
    add(ListImageLoadingEvent.LOAD);
  }

  @override
  Stream<List<Photo>> mapEventToState(ListImageLoadingEvent event) async* {
    switch(event){
      case ListImageLoadingEvent.LOAD:
        var album = await ListImagesLandingRepository().fetchListImage(getListImageUrl());
        yield album?.photos;
        break;
      case ListImageLoadingEvent.LOADING:
        break;
      case ListImageLoadingEvent.LOAD_COMPLETED:
        break;
      case ListImageLoadingEvent.ERROR:
        break;
    }
  }

  String getListImageUrl();
}