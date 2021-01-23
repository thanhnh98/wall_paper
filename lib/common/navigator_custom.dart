import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_new/model/horizontal_landing_item.dart';
import 'package:flutter_app_new/model/photo.dart';
import 'package:flutter_app_new/model/videos/video.dart';
import 'package:flutter_app_new/screen/album/album.dart';
import 'package:flutter_app_new/screen/photo_detail.dart';
import 'package:flutter_app_new/screen/search/search_screen.dart';
import 'package:flutter_app_new/screen/video_detail.dart';
import 'package:flutter_app_new/screen/video_screen.dart';

class NavigatorGlobal{
  static void pushAlbumHomePage(BuildContext context, String url){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AlbumHomePage(url)));
  }

  static Future pushPhotoDetailPage(BuildContext context, Photo photo){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PhotoDetailPage(photo)));
  }

  static Future pushSearchPage(BuildContext context){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SearchScreen()));
  }

  static Future pushVideoPage(BuildContext context){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => VideoPage()));
  }

  static Future pushVideoDetailPage(BuildContext context, VideoModel video){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => VideoDetailPage(video)));
  }
}