import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_app_new/bloc/photo/photo_detail_event.dart';
import 'package:flutter_app_new/common/app_preferences.dart';
import 'package:flutter_app_new/helper/image_downloader.dart';
import 'package:flutter_app_new/model/photo.dart';
import 'package:flutter_app_new/repository/image_repository.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:url_launcher/url_launcher.dart';

class PhotoDetailBloc extends Bloc<PhotoDetailEvent, Photo>{
  Photo _photo;
  StreamController<int> _imageDownloadStream;
  var _lastPathDownloaded = "";

  PhotoDetailBloc({Photo photo}) : super(photo){
    this._photo = photo;
    _imageDownloadStream = StreamController.broadcast();
  }

  void openUrl(String url) async {
    if (await canLaunch(url)){
      await launch(url);
    }else {
      throw 'Could not launch $url';
    }
  }

  void downloadImage(String url) async {
    _imageDownloadStream.add(0);
    ImageDownloader.callback(onProgressUpdate: (String imageId, int progress) {
      _imageDownloadStream.add(progress);
    });
    String pathResult =  await ImageDownloadHelper.downloadImageUrl(url);

    _lastPathDownloaded = pathResult;
  }

  @override
  Stream<Photo> mapEventToState(PhotoDetailEvent event) {
    switch(event){
      case PhotoDetailEvent.LIKED:
        break;
      case PhotoDetailEvent.UN_LIKED:
        break;
    }
  }

  Stream<int> get imageDownloadedPercent => _imageDownloadStream.stream;

  void dispose(){
    _imageDownloadStream.close();
  }

  Future<Photo> getPhotoById(int photoId) async{
      Photo photo = await ImageRepository().fetchPhotoById(photoId);
      bool isLiked = await AppPreferences.getImageLikedById(photoId);
      photo.liked = isLiked;
      print("$isLiked liked ${photo.liked}");
      return photo;
  }
}