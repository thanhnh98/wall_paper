import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_new/bloc/home/photo_liked/photo_favourite_bloc.dart';
import 'package:flutter_app_new/bloc/home/photo_liked/photo_favourite_event.dart';
import 'package:flutter_app_new/bloc/photo/photo_detail_bloc.dart';
import 'package:flutter_app_new/common/color_utils.dart';
import 'package:flutter_app_new/common/constant.dart';
import 'package:flutter_app_new/common/navigator_custom.dart';
import 'package:flutter_app_new/common/sized_config.dart';
import 'package:flutter_app_new/common/style_utils.dart';
import 'package:flutter_app_new/generated/l10n.dart';
import 'package:flutter_app_new/helper/deeplink.dart';
import 'package:flutter_app_new/model/horizontal_landing_item.dart';
import 'package:flutter_app_new/model/photo.dart';
import 'package:flutter_app_new/utils/string_utils.dart';
import 'package:flutter_app_new/widget/vertical_left_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  State<StatefulWidget> createState(){
   return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver, DeeplinkCallbackListener{
  _HomeScreenState();

  @override
  void initState() {
    super.initState();
    DeeplinkHelper.newInstance.registerDeeplinkListener(this);
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      DeeplinkHelper.newInstance.excuteExistingDeeplink();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state){
      // case AppLifecycleState.resumed:
      //   print("resumed");
      //   context?.read<PhotoFavouriteBloc>()?.add(PhotoFavouriteEvent.LOAD);
      //   break;

      case AppLifecycleState.inactive:
        print('AppLifecycleState.inactive');
        break;
      case AppLifecycleState.paused:
        print('AppLifecycleState.paused');
        break;
      case AppLifecycleState.resumed:
        print('AppLifecycleState.resumed');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [CommonColor.primaryColorDark, CommonColor.primaryColor]
            )
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
                  Hero(
                      tag: "search",
                      child: _buildSearchComponent()
                  ),
                  SizedBox(
                    height: SizeConfig.verticalSize(2),
                  ),
                  _buildSloganComponent(),
                  SizedBox(
                    height: SizeConfig.verticalSize(1),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: SizeConfig.horizontalSize(5)),
                    child: RichText(
                      text: TextSpan(
                          text: "1000+ ${S.current.photo}",
                          style: CommonStyle.textStyleCustom(
                            size: CommonStyle.super_extra_text_size,
                            color: CommonColor.white,
                            fontStyle: FontStyle.normal,
                          )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.verticalSize(4),
                  ),
                  Container(
                      child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildListImageItem(),
                    ),
                  )),
                ],
              ),
            )),
        DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.3,
            maxChildSize: 0.9,
            builder: (context, scrollController){
                return Container(
                  height: SizeConfig.blockSizeVertical * 30,
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: SizeConfig.verticalSize(5),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: BorderRadius.circular(15).topRight,
                      topLeft: BorderRadius.circular(15).topLeft,
                    ),
                    color: CommonColor.primaryColorLight,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: SizeConfig.horizontalSize(5), top: SizeConfig.horizontalSize(5), right: SizeConfig.horizontalSize(5)),
                    child: BlocBuilder<PhotoFavouriteBloc, List<Photo>>(builder: (context, listImg){
                      if(listImg == null || listImg?.length == 0)
                        return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                            controller: scrollController,
                            itemCount: 1,
                            itemBuilder: (context, index){
                              return _buildListFavouriteEmpty();
                            });
                      return StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        controller: scrollController,
                        itemCount: listImg.length + 1,
                        itemBuilder: (context, index){
                          if (index == 0)
                            return Container(
                              height: 32,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: RichText(
                                  text: TextSpan(
                                    text: S.current.favourite_list,
                                    style: CommonStyle.textStyleCustom(
                                      size: 24.0,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          else
                            return _buildHorizontalItem(listImg[index - 1]);
                        },
                        staggeredTileBuilder: (index){
                          return new StaggeredTile.count(index == 0? 2 : 1, index == 0 ? 0.3 : 1);
                        },
                      );
                    })
                  ),
                );
        })
      ],
    )));
  }
  Widget _buildSloganComponent(){
    return Container(
      margin: EdgeInsets.only(left: SizeConfig.horizontalSize(5)),
      child: RichText(
        text: TextSpan(
            text: S.current.app_slogan,
            style: CommonStyle.textStyleCustom(
                size: CommonStyle.normal_text_size,
                color: CommonColor.white,
                fontStyle: FontStyle.normal,
                weight: FontWeight.normal)),
      ),
    );
  }

  Widget _buildSearchComponent(){
    return GestureDetector(
      onTap: () {
        NavigatorGlobal.pushSearchPage(context);
      },
      child: Container(
        height: 40,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.7)),
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Stack(
            children: [
              Align(
                alignment: Alignment(-1, 0),
                child: RichText(
                  text: TextSpan(
                      text: S.current.search,
                      style: CommonStyle.textStyleCustom(
                          size: 18.0, weight: FontWeight.normal)),
                ),
              ),
              Align(
                  alignment: Alignment(1, 0),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 32,
                  ))
            ],
          ),
        ),
      ),
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

  Widget _buildListFavouriteEmpty(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: RichText(
              text: TextSpan(
                text: S.current.favourite_list,
                style: CommonStyle.textStyleCustom(
                  size: 20.0,
                  weight: FontWeight.bold,
                ),
              ),
            ),
          )
        ),
        Center(
          child: Image.asset(
            "assets/empty_image.png",
            width: SizeConfig.horizontalSize(15),
            height: SizeConfig.horizontalSize(15),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: S.current.favourite_photo_des,
              style: CommonStyle.textStyleCustom(
                size: 14.0,
                weight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalItem(Photo photo){
    String imgPath =
    photo.liked ? "assets/heart_solid.svg" : "assets/heart_empty.svg";
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
          onTap: () {
            NavigatorGlobal.pushPhotoDetailPage(context, photo).then((value) => {
            context?.read<PhotoFavouriteBloc>()?.add(PhotoFavouriteEvent.LOAD)
            });
          },
          child: Stack(
            children: [
              Align(
                child: ClipRRect(
                    borderRadius: new BorderRadius.all(Radius.circular(10)),
                    child: Center(
                      child: Hero(
                        tag: photo.id,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/img_loading.gif',
                          image: photo.src.tiny,
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                          alignment: Alignment.center,
                        ),
                      )
                    )),
              ),
              Align(
                child: GestureDetector(
                  onTap: () {
                    // photo.liked = !photo.liked;
                    // setState(() {
                    //   imgPath = photo.liked
                    //       ? "assets/heart_solid.svg"
                    //       : "assets/heart_empty.svg";
                    // });
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[100].withOpacity(0.5)),
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: SvgPicture.asset(imgPath),
                    ),
                  ),
                ),
                alignment: Alignment.bottomRight,
              )
            ],
          )),
    );
  }

  Widget _buildItemSingle(HorizontalLandingItemModel item) {
    return GestureDetector(
      onTap: () {
        NavigatorGlobal.pushAlbumHomePage(context, item.url);
      },
      child: Container(
          width: SizeConfig.horizontalSize(50),
          height: SizeConfig.verticalSize(40),
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
              //   child: Container(
              //     width: double.infinity,
              //     height: double.infinity,
              //     color: Colors.blueGrey,
              //   ),
              // ),
              Align(
                alignment: Alignment(-1, 1),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.6),
                      borderRadius: BorderRadius.only(
                          topRight: BorderRadius.circular(15).topRight,
                          bottomLeft: BorderRadius.circular(15).bottomLeft)),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: RichText(
                      text: TextSpan(
                          text: item.title,
                          style:
                              CommonStyle.textStyleCustom(color: Colors.white)),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void onReceivedUri(String url) async {
    Photo photo = await context?.read<PhotoDetailBloc>()?.getPhotoById(StringUtils.getPhotoIdFromUrl(url));
    print("photo: ${photo}");
    NavigatorGlobal.pushPhotoDetailPage(context, photo);
  }
}
