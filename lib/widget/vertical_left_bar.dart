import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_new/common/style_utils.dart';

class VerticalLeftSideBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _VerticalLeftSideState();

}

class _VerticalLeftSideState extends State<VerticalLeftSideBar>{

  int currentTabSelect = 0;
  final int photoTabIndex = 0;
  final int videoTabIndex = 1;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 20),
      child: Column(
        children: [
          RotatedBox(
            quarterTurns: -1,
            child: GestureDetector(
              onTap: (){
                onTabSelected(photoTabIndex);
              },
              child: RichText(
                text: TextSpan(
                    text: "Photos",
                    style: CommonStyle.textStyleCustom(
                        color: currentTabSelect == photoTabIndex? Colors.white : Colors.grey
                    )
                ),
              ),
            )
          ),
          SizedBox(height: 20,),
          RotatedBox(
            quarterTurns: -1,
            child: GestureDetector(
              onTap: (){
                onTabSelected(videoTabIndex);
                },
              child: RichText(
                text: TextSpan(
                  text: "Videos",
                  style: CommonStyle.textStyleCustom(
                      color: currentTabSelect == videoTabIndex? Colors.white : Colors.grey
                  ),

                ),
              ),
            )
          ),
        ],
      ),
    );
  }

  void onTabSelected(int tabIndex){
    setState(() {
      this.currentTabSelect = tabIndex;
    });
  }

}