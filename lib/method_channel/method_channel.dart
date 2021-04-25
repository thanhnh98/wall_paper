import 'package:flutter/services.dart';

class AppMethodChannel{
  static final MethodChannel wallpaperUpdateMethod = MethodChannel('update_wallpaper');
  static final MethodChannel deeplinkMethodChannel = MethodChannel('deeplink_channel');
}