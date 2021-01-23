import 'dart:convert';

import 'package:flutter_app_new/common/network/network.dart';
import 'package:flutter_app_new/model/album.dart';
import 'package:flutter_app_new/model/videos/video.dart';

class VideoRepository extends ClientNetwork{
    Future<AlbumModel> getListVideosPopular(String url) async{
      final response = await get(url);

      if(response.statusCode == 200){
        return AlbumModel.fromJson(json.decode(response.body));
      }
      else{
        throw Exception("Get list videos failed");
      }
    }
}