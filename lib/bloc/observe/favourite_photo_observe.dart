import 'package:flutter/cupertino.dart';
import 'package:flutter_app_new/bloc/home/photo_liked/photo_favourite_bloc.dart';

class FavouritePhotoObserve{
  static PhotoFavouriteBloc _photoFavouriteBloc;

  FavouritePhotoObserve(BuildContext context, {Key key}){
    _photoFavouriteBloc = PhotoFavouriteBloc();
  }

  static PhotoFavouriteBloc of() => _photoFavouriteBloc??=PhotoFavouriteBloc();

}