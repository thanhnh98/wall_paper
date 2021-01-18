import 'dart:convert';

import 'package:flutter_app_new/model/list_image_model.dart';
import 'package:flutter_app_new/model/photo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences{
    static String _IMAGE_HASH = "image_hash";
    static AppPreferences instance;

    static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


    static Future<void> putLikeImageById(Photo photo, bool isLiked) async {
        SharedPreferences pref = await _prefs;
        ListImageModel listImageLiked = await getLikedImages();

        if(listImageLiked.photos == null){
            listImageLiked.photos = List();
        }

        if(listImageLiked.photos.contains(photo)){
            for (int i = 0; i < listImageLiked.photos.length; ++i) {
                if (listImageLiked.photos[i].id == photo.id) {
                    if (isLiked) {
                        listImageLiked.photos[i] = photo;
                        break;
                    }
                    else {
                        listImageLiked.photos.removeAt(i);
                        break;
                    }
                }
            }
        }else{
            if(isLiked)
                listImageLiked.photos.add(photo);
        }

        listImageLiked.nextPage = "";
        pref.setString(_IMAGE_HASH, json.encode(listImageLiked));
        return;
    }

    static Future<ListImageModel> getLikedImages() async{
        SharedPreferences pref = await _prefs;

        String jsonListData = pref.getString(_IMAGE_HASH);

        if(jsonListData == null)
            return new ListImageModel();

        ListImageModel listImageLocal = ListImageModel.fromJson(json.decode(jsonListData));
        print("data neew ${json.encode(listImageLocal)}");

        return listImageLocal;
    }

}