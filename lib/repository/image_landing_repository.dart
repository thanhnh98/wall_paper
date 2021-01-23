import 'dart:convert';

import 'package:flutter_app_new/common/network/network.dart';
import 'package:flutter_app_new/model/album.dart';

class ListImagesLandingRepository extends ClientNetwork{
  Future<AlbumModel> fetchListImage(String url) async{
    final response = await super.get(url);
    if(response.statusCode == 200) {
      return AlbumModel.fromJson(json.decode(response.body));
    }
    else
      throw Exception("load api failed");
  }
}