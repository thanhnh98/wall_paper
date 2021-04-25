import 'package:flutter/services.dart';
import 'package:flutter_app_new/method_channel/method_channel.dart';

class DeeplinkHelper{
  static DeeplinkHelper newInstance = DeeplinkHelper();
  static MethodChannel _deeplinkChannel = AppMethodChannel.deeplinkMethodChannel;
  DeeplinkCallbackListener _listener;
  void registerDeeplinkListener(DeeplinkCallbackListener listener){
    _listener = listener;
    _deeplinkChannel.setMethodCallHandler((call){
      if (_listener != null && call.arguments != null){
        excuteExistingDeeplink();
      }
      return;
    });
  }

  void excuteExistingDeeplink(){
    _deeplinkChannel.invokeMethod("handle_deeplink").then((value) => {
        _listener.onReceivedUri(value.toString())
    });
  }
}

abstract class DeeplinkCallbackListener{
  void onReceivedUri(String url);
}