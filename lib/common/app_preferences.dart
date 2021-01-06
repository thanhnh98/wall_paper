import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app_new/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences{
    static String _IMAGE_HASH = "image_hash";
    static AppPreferences instance;

    static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


    static Future<void> putLikeImageById(int imageId, bool isLiked) async {

        SharedPreferences pref = await _prefs;
        String hashString = pref.getString(_IMAGE_HASH);
        if (hashString == null){
            Map<int, bool> map = Map();
            map[imageId] = isLiked;
            String strMap = json.encode(map);
            print(strMap);
            pref.setString(_IMAGE_HASH, strMap);
        }
        else{
            String strMap = pref.getString(_IMAGE_HASH);
            print(strMap);
        }
    }

}