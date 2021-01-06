import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_new/bloc/home/list_image_bloc.dart';
import 'package:flutter_app_new/bloc/home/list_image_loading_event.dart';
import 'package:flutter_app_new/bloc/home/section/animal.dart';
import 'package:flutter_app_new/bloc/home/section/fashion.dart';
import 'package:flutter_app_new/bloc/home/section/nature.dart';
import 'package:flutter_app_new/bloc/home/section/text.dart';
import 'package:flutter_app_new/common/color_utils.dart';
import 'package:flutter_app_new/common/constant.dart';
import 'package:flutter_app_new/common/style_utils.dart';
import 'package:flutter_app_new/model/horizontal_landing_item.dart';
import 'package:flutter_app_new/model/photo.dart';
import 'package:flutter_app_new/widget/vertical_left_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage("assets/cover_image.jpg"),
                      fit: BoxFit.cover,
                    )
                ),
                child: new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: new Container(
                    decoration: new BoxDecoration(
                        color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            height: 40,
                            margin: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(0.7)
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                                right: 20
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment(-1,0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Tìm kiếm",
                                        style: CommonStyle.textStyleCustom(
                                          size: 18.0,
                                          weight: FontWeight.normal
                                        )
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment(1,0),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                      size: 32,
                                    )
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                          margin: EdgeInsets.only(left: 20),
                          child: RichText(
                            text: TextSpan(
                                text: "Wallpaper - Quickly, Easy and Simply",
                                style: CommonStyle.textStyleCustom(
                                    size: CommonStyle.normal_text_size,
                                    color: CommonColor.white,
                                    fontStyle: FontStyle.normal,
                                    weight: FontWeight.normal
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: RichText(
                            text: TextSpan(
                                text: "1000+ Photos",
                                style: CommonStyle.textStyleCustom(
                                  size: CommonStyle.super_extra_text_size,
                                  color: CommonColor.white,
                                  fontStyle: FontStyle.normal,
                                )
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _buildListImageItem(),

                            ),
                          )
                        ),
            ],
          ),
        )
    ),]
    ,
    )
    )
    );
  }

  List<Widget> _buildListImageItem() {
    List<Widget> listItem = List();

    listItem.add(VerticalLeftSideBar());
    listItem.add(SizedBox(width: 20));

    for (HorizontalLandingItemModel item in Constant.getListTopicLanding()) {
      listItem.add(_buildItemSingle(item));
    }

    return listItem;
  }

  Widget _buildItemSingle(HorizontalLandingItemModel item) {
    return Container(
        width: 180,
        height: 300,
        margin: EdgeInsets.only(right: 10),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FadeInImage.assetNetwork(
                placeholder: '',
                image: item.assetsImageCover,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
            ),
            Align(
              alignment: Alignment(-1, 1),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.6),
                    borderRadius: BorderRadius.only(
                        topRight: BorderRadius
                            .circular(15)
                            .topRight,
                        bottomLeft: BorderRadius
                            .circular(15)
                            .bottomLeft
                    )
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: RichText(
                    text: TextSpan(
                        text: item.title,
                        style: CommonStyle.textStyleCustom(
                            color: Colors.white
                        )
                    ),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}