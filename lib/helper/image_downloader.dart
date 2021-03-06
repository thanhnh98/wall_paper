import 'package:flutter/services.dart';
import 'package:flutter_app_new/bloc/wall_paper/wall_paper_event.dart';
import 'package:flutter_app_new/method_channel/method_channel.dart';
import 'package:image_downloader/image_downloader.dart';

class ImageDownloadHelper {
  static MethodChannel _wallpaperUpdateMethod = AppMethodChannel.wallpaperUpdateMethod;

  static var _HOME_SCREEN = "set_home_screen";
  static var _LOCK_SCREEN = "set_lock_screen";
  static var _BOTH_SCREENS = "set_both_screens";

  static var RESULT_FAILED = "null";
  
  static Future<String> downloadImageUrl(String url) async {
    try {
      print("downloading url: ${url}");
      var imageId = await ImageDownloader.downloadImage(url);
      var path = await ImageDownloader.findPath(imageId);

      if (imageId == null) {
        return Future.value(RESULT_FAILED);
      }
      return Future.value(path);
    } on PlatformException catch (error) {
      return Future.value(RESULT_FAILED);
    }
  }
  
  static Future<String> setBackground(String path, ScreenType type) async{
    String location = _HOME_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
    print("set background ${path}, type = ${type.toString()}");
    if (type == ScreenType.HOME_SCREEN) location = _HOME_SCREEN;

    if (type == ScreenType.LOCK_SCREEN) location = _LOCK_SCREEN;

    if (type == ScreenType.BOTH_SCREENS) location = _BOTH_SCREENS;

    String pathResult = RESULT_FAILED;

    try {
      await _wallpaperUpdateMethod.invokeMethod(location, path).then((value) => {
        pathResult = value
      });
    } on PlatformException {

    }
    
    return pathResult;

  }

  static Future<String> setDownloadAndBackground(String url, ScreenType type) async {
    return downloadImageUrl(url).then((value) => setBackground(value, type));
  }

  // static Future<String> downloadImage(String url) async {
  //   var imageId = await ImageDownloader.downloadImage(url);
  //   if (imageId == null) {
  //     return Future.value(RESULT_FAILED);
  //   }
  //
  //   //Below is a method of obtaining saved image information.
  //   var fileName = await ImageDownloader.findName(imageId);
  //   var path = await ImageDownloader.findPath(imageId);
  //   var size = await ImageDownloader.findByteSize(imageId);
  //   var mimeType = await ImageDownloader.findMimeType(imageId);
  //
  //   return Future.value(path);
  //
  // }
}
