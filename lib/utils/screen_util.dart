import 'package:flutter/cupertino.dart';

class ScreenUtils{

  ScreenUtils({this.width, this.height});

  double height;
  double width;

  static ScreenUtils of(BuildContext context){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ScreenUtils(width: width, height: height);
  }
}