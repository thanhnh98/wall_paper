import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_new/common/style_utils.dart';
import 'package:flutter_app_new/list_image/wall_paper/wall_paper_bloc.dart';
import 'package:flutter_app_new/list_image/wall_paper/wall_paper_event.dart';
import 'package:flutter_app_new/model/photo.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WallpaperDialog extends StatefulWidget{
  Photo _photo;
  WallpaperDialog(this._photo);
  @override
  State<StatefulWidget> createState() => _WallpaperState(_photo);
}

class _WallpaperState extends State<WallpaperDialog>{
  Photo _photo;
  WallPaperBloc _wallPaperBloc;

  _WallpaperState(this._photo){
    _wallPaperBloc = WallPaperBloc(_photo);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
        backgroundColor: Colors.black45,
        child: Center(
          child: _buildContentDialog(),
        )
    );
  }

  Widget _buildContentDialog(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            text: "Select one",
            style: CommonStyle.titleTextStyle
          )
        ),
        SizedBox(
          height: 30,
        ),
        _buildOnlyHomeScreenIcon(),
        SizedBox(
          height: 20,
        ),
        _buildOnlyLockScreenIcon(),
        SizedBox(
          height: 20,
        ),
        _buildHomeAndLockIcon()
      ],
    );
  }

  Widget _buildOnlyHomeScreenIcon(){
    return _buildItemState(
      Icon(
        Icons.smartphone,
        size: 50,
      ),
      "Home Screen",
      ScreenType.HOME_SCREEN,
      _wallPaperBloc.homeScreenStreamController
    );
  }

  Widget _buildOnlyLockScreenIcon(){
    return _buildItemState(
      Icon(
        Icons.phonelink_lock,
        size: 50,
      ),
      "Lock Screen",
      ScreenType.LOCK_SCREEN,
      _wallPaperBloc.lockScreenStreamController
    );
  }

  Widget _buildHomeAndLockIcon(){
    return _buildItemState(
      Icon(
        Icons.fit_screen,
        size: 50,
      ),
      "Home-Lock Screen",
      ScreenType.BOTH_SCREENS,
      _wallPaperBloc.bothScreenStreamController
    );
  }

  Widget _buildItemState(Widget icon, String text, ScreenType type, Stream stream) {
    return Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: StreamBuilder<WallPaperEvent>(
            stream: stream,
            builder: (context, snapshot){
              WallPaperEvent event = snapshot?.data;

              if(event != null && event == WallPaperEvent.LOADING)
                return _buildLoading();

              else if (event != null && event == WallPaperEvent.COMPLETED)
                return _buildComplete();

              else
                return _buildItem(icon, text, type);
            },
          )
        )
    );
  }

  Widget _buildItem(Widget icon, String text, ScreenType type){
    return GestureDetector(
      onTap: (){
        print("type = $type");
        _wallPaperBloc.requestSetBackground(type);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.all(4.0), child: Center(child: icon)),
          SizedBox(height: 15,),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: text,
                  style: CommonStyle.textStyleCustom(
                      color: Color(0xff333333)
                  )
              )
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Padding(
      padding: EdgeInsets.all(30),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.green),
      ),
    );
  }

  Widget _buildComplete(){
    return Padding(
      padding: EdgeInsets.all(30),
      child: SvgPicture.asset("assets/ic_completed.svg")
    );
  }
}