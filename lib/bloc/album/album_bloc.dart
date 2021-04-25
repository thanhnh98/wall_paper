import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter_app_new/common/app_preferences.dart';
import 'package:flutter_app_new/common/default_image_category.dart';
import 'package:flutter_app_new/model/album.dart';
import 'package:flutter_app_new/model/list_image_model.dart';
import 'package:flutter_app_new/model/photo.dart';
import 'package:flutter_app_new/repository/image_repository.dart';

import 'album_event.dart';

class AlbumBloc extends Bloc<AlbumEvent, List<Photo>>{
  String listImageUrl;
  AlbumBloc({this.listImageUrl}) : super(null){
    add(AlbumEvent.LOAD);
  }

  var _itemPerPage = new Random().nextInt(10) + 30;
  var _isLoadingMore = false;

  ListImageModel _data = ListImageModel();
  List<Photo> listPhotos = [];
  AlbumModel albumHolder;

  Stream<List<Photo>> init() async*{
    add(AlbumEvent.LOAD);
  }

  @override
  Stream<List<Photo>> mapEventToState(AlbumEvent event) async* {
    switch(event){
      case AlbumEvent.LOAD:
        listPhotos.clear();
        await _loadImage().then((value) => {
          _data.photos = value.photos,
          _data.nextPage = value.next_page,
          listPhotos.addAll(value.photos),
          albumHolder = value
        }).whenComplete(() => {
          print("LOADED COMPLETED")
        });
        yield await markLikedImage(listPhotos);
        break;

      case AlbumEvent.LOAD_MORE:
        if(!_isLoadingMore) {
          _isLoadingMore = true;
          await _loadMoreAlbumImage().then((value) =>
          {
            if(value != null){
              _data.photos.addAll(value.photos),
              _data.nextPage = value.next_page,
              listPhotos.addAll(value.photos),
              _isLoadingMore = false,
            }
          }).whenComplete(() => {
            print("LOAD MORE COMPLETED ${listPhotos?.length}")
          });
          yield await markLikedImage(listPhotos);
        }
        break;
      case AlbumEvent.REFRESH:
        listPhotos.clear();
        await _loadImageRandom().then((value) => {
          _data.photos = value.photos,
          _data.nextPage = value.next_page,
          listPhotos.addAll(value.photos),
          albumHolder = value
        }).whenComplete(() => {
          print("Refresh COMPLETED")
        });
        yield await markLikedImage(listPhotos);
        break;
      case AlbumEvent.COMPLETED:
        break;
    }
  }

  Future<List<Photo>> markLikedImage(List<Photo> listPhotos) async {

    ListImageModel listLikedImageModel = await AppPreferences.getLikedImages();
    print("PROCESSING -> ${listLikedImageModel.toJson()}");
    if(listLikedImageModel.photos == null || listLikedImageModel.photos.isEmpty)
      return List.of(listPhotos);

    listLikedImageModel.photos.forEach((likedPhoto) {
      listPhotos.where((element) => element.id == likedPhoto.id).forEach((foundPhoto) {
        foundPhoto.liked = true;
      });
    });

    return List.of(listPhotos);
  }

  Future<AlbumModel> _loadMoreAlbumImage() async{
    if (_data != null && _data.nextPage != null) {
      AlbumModel album = await ImageRepository().fetchAlbumWithUrl(
          _data.nextPage);
      return album;
    }
  }

  Future<AlbumModel> _loadImageRandom() async{
    List<String> listCategory = ImageCategory.listDefaultCategory;
    String param = listCategory[Random().nextInt(listCategory.length)];
    int itemPerPage = _itemPerPage;
    int totalPage = (albumHolder.total_results / itemPerPage) as int;
    int page = new Random().nextInt(totalPage) + 1;

    try {
      AlbumModel album = await ImageRepository().fetchAlbumWithUrl(listImageUrl + (totalPage > 0 ? "&page=$page" : ""));
      return album;
    }
    catch(err){
    }
  }

  Future<AlbumModel> _loadImage() async{
    try {
      AlbumModel album = await ImageRepository().fetchAlbumWithUrl(listImageUrl);
      return album;
    }
    catch(err){
    }
  }
}