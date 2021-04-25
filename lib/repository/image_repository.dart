

import 'dart:convert';

import 'package:flutter_app_new/common/network/network.dart';
import 'package:flutter_app_new/model/album.dart';
import 'package:flutter_app_new/model/photo.dart';

class ImageRepository extends ClientNetwork{
  Future<AlbumModel> fetchAlbum(int startPage, int perPage) async{
    final response = await super.get('https://api.pexels.com/v1/curated?page=$startPage&per_page=$perPage}');
    if(response.statusCode == 200) {
      return AlbumModel.fromJson(json.decode(response.body));
    }
    else
      throw Exception("load api failed");
  }

  Future<AlbumModel> fetchAlbumWithUrl(String url) async{
    final response = await super.get(url);
    if(response.statusCode == 200) {
      return AlbumModel.fromJson(json.decode(response.body));
    }
    else
      throw Exception("load api failed");
  }
  
  Future<Photo> fetchPhotoById(int photoId) async{
    final res = await get("https://api.pexels.com/v1/photos/$photoId");

    if (res.statusCode == 200){
      return Photo.fromJson(json.decode(res.body));
    }
    else
      throw Exception("load photo failed");
  }
}