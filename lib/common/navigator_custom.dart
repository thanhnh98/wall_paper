import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_new/model/horizontal_landing_item.dart';
import 'package:flutter_app_new/model/photo.dart';
import 'package:flutter_app_new/screen/album.dart';
import 'package:flutter_app_new/screen/photo_detail.dart';

class NavigatorGlobal{
  static void pushAlbumHomePage(BuildContext context, HorizontalLandingItemModel item){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AlbumHomePage(item.url)));
  }

  static Future pushPhotoDetailPage(BuildContext context, Photo photo){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PhotoDetailPage(photo)));
  }
}