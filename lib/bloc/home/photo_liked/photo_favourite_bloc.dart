import 'package:flutter/services.dart';
import 'package:flutter_app_new/bloc/home/photo_liked/photo_favourite_event.dart';
import 'package:flutter_app_new/common/app_preferences.dart';
import 'package:flutter_app_new/model/photo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoFavouriteBloc extends Bloc<PhotoFavouriteEvent, List<Photo>>{

  PhotoFavouriteBloc() : super(null){
    add(PhotoFavouriteEvent.LOAD);
  }

  @override
  Stream<List<Photo>> mapEventToState(PhotoFavouriteEvent event) async* {
    switch(event){
      case PhotoFavouriteEvent.LOAD:
        List<Photo> listPhoto = [];
        await AppPreferences.getLikedImages().then((value) => {
          listPhoto = value?.photos?.where((element) => element.liked)?.toList()
        });
        yield listPhoto??[];
        break;
      case PhotoFavouriteEvent.INSERT:
        break;
      case PhotoFavouriteEvent.REMOVED:
        break;
    }
  }

  void likeImage(photo, isLiked) async {
    await AppPreferences.putLikeImageById(photo, isLiked);
    add(PhotoFavouriteEvent.LOAD);
  }
}