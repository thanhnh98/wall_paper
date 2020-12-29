import 'package:flutter/services.dart';
import 'package:flutter_app_new/list_image/wall_paper/wall_paper_event.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class ImageDownloadHelper {
  static MethodChannel _wallpaperUpdateMethod =
      const MethodChannel('update_wallpaper');

  static var _HOME_SCREEN = "set_home_screen";
  static var _LOCK_SCREEN = "set_lock_screen";
  static var _BOTH_SCREENS = "set_both_screens";

  static var _resultOk = "ok";

  static Future<bool> downloadImageUrl(String url) async {
    try {
      var imageId = await ImageDownloader.downloadImage(url);
      if (imageId == null) {
        return Future.value(false);
      }
      return Future.value(true);
    } on PlatformException catch (error) {
      print(error);
      return Future.value(false);
    }
  }

  static Future<bool> setBackground(String url, ScreenType type) async {
    return _downloadAndSetBackground(url, type);
  }

  static Future<bool> _downloadAndSetBackground(
      String url, ScreenType type) async {
    var imageId = await ImageDownloader.downloadImage(url);
    if (imageId == null) {
      return Future.value(false);
    }

    //Below is a method of obtaining saved image information.
    var fileName = await ImageDownloader.findName(imageId);
    var path = await ImageDownloader.findPath(imageId);
    var size = await ImageDownloader.findByteSize(imageId);
    var mimeType = await ImageDownloader.findMimeType(imageId);

    String location =
        _HOME_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;

    if (type == ScreenType.HOME_SCREEN) location = _HOME_SCREEN;

    if (type == ScreenType.LOCK_SCREEN) location = _LOCK_SCREEN;

    if (type == ScreenType.BOTH_SCREENS) location = _BOTH_SCREENS;

    bool isSuccessFul = false;

    try {
      await _wallpaperUpdateMethod.invokeMethod(location, path).then((value) => {
            if (value == _resultOk) {isSuccessFul = true}
          });
    } on PlatformException {}

    return Future.value(isSuccessFul);

  }
}
