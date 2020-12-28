import 'package:flutter/services.dart';
import 'package:flutter_app_new/list_image/wall_paper/wall_paper_event.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class ImageDownloadHelper{
  static Future<bool> downloadImageUrl(String url) async {

    try {
      var imageId = await ImageDownloader.downloadImage(url);
      if (imageId == null) {
        return Future.value(false);
      }

      // Below is a method of obtaining saved image information.
      // var fileName = await ImageDownloader.findName(imageId);
      // var path = await ImageDownloader.findPath(imageId);
      // var size = await ImageDownloader.findByteSize(imageId);
      // var mimeType = await ImageDownloader.findMimeType(imageId);

      return Future.value(true);
    }
    on PlatformException catch (error) {
      print(error);
      return Future.value(false);
    }

  }

  static Future <bool> setBackground(String url, ScreenType type) async{
    return _downloadAndSetBackground(url, type);
  }

  static Future<bool> _downloadAndSetBackground(String url, ScreenType type) async {
    var imageId = await ImageDownloader.downloadImage(url);
    if (imageId == null) {
      return Future.value(false);
    }

    //Below is a method of obtaining saved image information.
    var fileName = await ImageDownloader.findName(imageId);
    var path = await ImageDownloader.findPath(imageId);
    var size = await ImageDownloader.findByteSize(imageId);
    var mimeType = await ImageDownloader.findMimeType(imageId);

    int location = WallpaperManager
        .HOME_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;

    if(type == ScreenType.HOME_SCREEN)
      location = WallpaperManager.HOME_SCREEN;

    if(type == ScreenType.LOCK_SCREEN)
      location = WallpaperManager.LOCK_SCREEN;

    if(type == ScreenType.BOTH_SCREENS)
      location = WallpaperManager.BOTH_SCREENS;

    try {
      await WallpaperManager.setWallpaperFromFile(path, location);
      return Future.value(true);
    } on PlatformException {
    }
    return Future.value(false);
  }

}