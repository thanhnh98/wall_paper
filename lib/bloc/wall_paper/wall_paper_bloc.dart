import 'dart:async';

import 'package:flutter_app_new/bloc/wall_paper/wall_paper_event.dart';
import 'package:flutter_app_new/helper/image_downloader.dart';
import 'package:flutter_app_new/main.dart';
import 'package:flutter_app_new/model/photo.dart';
import 'package:flutter_app_new/utils/screen_util.dart';
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
    //print("DOAWNLOADED ${_lastPathDownloaded}");
    if(_lastPathDownloaded != null && _lastPathDownloaded.isNotEmpty) {
      try {
        pathDownloaded = await ImageDownloadHelper.setBackground(_lastPathDownloaded, type);
      }catch(e){
        _lastPathDownloaded = await ImageDownloadHelper.downloadImageUrl(generateMagicUrl(_photo));
        pathDownloaded = await ImageDownloadHelper.setBackground(_lastPathDownloaded, type);
      }
    }
    else {
      _lastPathDownloaded = await ImageDownloadHelper.downloadImageUrl(generateMagicUrl(_photo));
      pathDownloaded = await ImageDownloadHelper.setBackground(_lastPathDownloaded, type);
    }
    //print("final result --> ${pathDownloaded}");
    if(pathDownloaded == null || pathDownloaded == ImageDownloadHelper.RESULT_FAILED)
      stream.add(WallPaperEvent.ERROR);
    else {
      this._lastPathDownloaded = pathDownloaded;
      stream.add(WallPaperEvent.COMPLETED);
    }
  }

  String generateMagicUrl(Photo photo){
    String originUrl = photo.src.original;
    return originUrl = photo.src.original+"?auto=compress";
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
