import 'dart:convert';

import 'package:flutter_app_new/model/list_image_model.dart';
import 'package:flutter_app_new/model/photo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences{
    static String _IMAGE_HASH = "image_hash";
    static AppPreferences instance;

    static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


    static Future<void> putLikeImageById(Photo photo, bool isLiked) async {
        print("id ${photo.id} is $isLiked");
        SharedPreferences pref = await _prefs;
        ListImageModel listImageLiked = await getLikedImages();
        photo.liked = isLiked;

        if(listImageLiked.photos == null){
            listImageLiked.photos = List();
        }

        bool isContainObject = false;

        for (int i = 0; i < listImageLiked.photos.length; ++i) {
            if (listImageLiked.photos[i].id == photo.id) {
                isContainObject = true;
                if (isLiked) {
                    listImageLiked.photos[i] = photo;
                    break;
                }
                else {
                    listImageLiked.photos.remove(listImageLiked.photos[i]);
                    break;
                }
            }
        }

        if(!isContainObject && isLiked){
            listImageLiked.photos.add(photo);
        }

        listImageLiked.nextPage = "";
        pref.setString(_IMAGE_HASH, json.encode(listImageLiked));
        return;
    }

    static _isContainObject(List<Photo> list, Photo o) {
        for (int i = 0; i < list.length; ++i) {
            if (o.id == list[i].id)
                return true;
        }
        return false;
    }

    static Future<ListImageModel> getLikedImages() async{
        SharedPreferences pref = await _prefs;

        String jsonListData = pref.getString(_IMAGE_HASH);

        if(jsonListData == null)
            return new ListImageModel();

        ListImageModel listImageLocal = ListImageModel.fromJson(json.decode(jsonListData));

        return listImageLocal;
    }

    static Future<bool> getImageLikedById(int id) async{
        SharedPreferences pref = await _prefs;
        String jsonListData = pref.getString(_IMAGE_HASH);
        bool isLiked;

        if (jsonListData == null)
            return false;

        ListImageModel listImageLocal = ListImageModel.fromJson(json.decode(jsonListData));

        if (listImageLocal == null)
            return false;

        if (listImageLocal.photos == null || listImageLocal.photos.isEmpty)
            return false;

        listImageLocal.photos.forEach((photo) {
            if (photo.id == id) {
                isLiked = true;
            }
        });
        return isLiked;

    }

}