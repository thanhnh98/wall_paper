import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_app_new/common/image_downloader.dart';
import 'package:flutter_app_new/list_image/photo/photo_detail_event.dart';
import 'package:flutter_app_new/model/photo.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:url_launcher/url_launcher.dart';

class PhotoDetailBloc extends Bloc<PhotoDetailEvent, Photo>{
  Photo _photo;
  StreamController<int> _imageDownloadStream;
  PhotoDetailBloc(Photo photo) : super(photo){
    this._photo = photo;
    _imageDownloadStream = StreamController();
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
    bool isDownloadSuccess =  await ImageDownloadHelper.downloadImageUrl(url);
    ImageDownloader.callback(onProgressUpdate: (String imageId, int progress) {
      print("callback: percent = $progress");
      _imageDownloadStream.add(progress);
    });
    print("DOWNLOAD STATUS: $isDownloadSuccess");
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
}