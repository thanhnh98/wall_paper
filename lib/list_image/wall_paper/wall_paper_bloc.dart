import 'dart:async';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:flutter_app_new/common/image_downloader.dart';
import 'package:flutter_app_new/list_image/wall_paper/wall_paper_event.dart';
import 'package:flutter_app_new/model/photo.dart';

class WallPaperBloc{
  Photo _photo;
  StreamController<WallPaperEvent> _homeScreenStreamController;
  StreamController<WallPaperEvent> _lockScreenStreamController;
  StreamController<WallPaperEvent> _bothScreenStreamController;


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

    bool isSuccessful = await ImageDownloadHelper.setBackground(_photo.src.original, type);

    if(isSuccessful)
      stream.add(WallPaperEvent.COMPLETED);
    else
      stream.add(WallPaperEvent.ERROR);
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
