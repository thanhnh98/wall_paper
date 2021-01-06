import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter_app_new/bloc/wall_paper/wall_paper_event.dart';
import 'package:flutter_app_new/common/image_downloader.dart';
import 'package:flutter_app_new/model/photo.dart';
import 'package:flutter_app_new/widget/download_progress_provider.dart';

class WallPaperBloc extends DownloadProgressProvider{
  Photo _photo;
  StreamController<WallPaperEvent> _homeScreenStreamController;
  StreamController<WallPaperEvent> _lockScreenStreamController;
  StreamController<WallPaperEvent> _bothScreenStreamController;

  String _lastPathDownloaded;


  WallPaperBloc(this._photo){
    _homeScreenStreamController = new StreamController();
    _lockScreenStreamController = new StreamController();
    _bothScreenStreamController = new StreamController();
  }

  void requestSetBackground(ScreenType type) async{
    StreamController<WallPaperEvent> stream;
    switch(type){

      case ScreenType.HOME_SCREEN:
        stream = _homeScreenStreamController;
        break;

      case ScreenType.LOCK_SCREEN:
        stream = _lockScreenStreamController;
        break;

      case ScreenType.BOTH_SCREENS:
        stream = _bothScreenStreamController;
        break;
    }
    stream.add(WallPaperEvent.LOADING);

    String pathDownloaded;

    if(_lastPathDownloaded != null) {
      try {
        print("existed path -> try set");
        pathDownloaded = await ImageDownloadHelper.setBackgroundOnly(_lastPathDownloaded, type);
      }catch(e){
        pathDownloaded = await ImageDownloadHelper.setDownloadAndBackground(_photo.src.original, type);
      }
    }
    else {
      pathDownloaded = await ImageDownloadHelper.setDownloadAndBackground(_photo.src.original, type);
    }

    if(pathDownloaded == null || pathDownloaded == ImageDownloadHelper.RESULT_FAILED)
      stream.add(WallPaperEvent.ERROR);
    else {
      this._lastPathDownloaded = pathDownloaded;
      stream.add(WallPaperEvent.COMPLETED);
    }
  }


  Stream<WallPaperEvent> get homeScreenStreamController => _homeScreenStreamController.stream;
  Stream<WallPaperEvent> get lockScreenStreamController => _lockScreenStreamController.stream;
  Stream<WallPaperEvent> get bothScreenStreamController => _bothScreenStreamController.stream;



  void dispose(){
    _bothScreenStreamController.close();
    _lockScreenStreamController.close();
    _homeScreenStreamController.close();
  }
}
