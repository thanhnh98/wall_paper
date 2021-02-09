import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_new/bloc/album/album_bloc.dart';
import 'package:flutter_app_new/bloc/album/album_event.dart';
import 'package:flutter_app_new/bloc/home/photo_liked/photo_favourite_bloc.dart';
import 'package:flutter_app_new/bloc/home/photo_liked/photo_favourite_event.dart';
import 'package:flutter_app_new/bloc/observe/favourite_photo_observe.dart';
import 'package:flutter_app_new/common/color_utils.dart';
import 'package:flutter_app_new/common/navigator_custom.dart';
import 'package:flutter_app_new/common/sized_config.dart';
import 'package:flutter_app_new/common/style_utils.dart';
import 'package:flutter_app_new/generated/l10n.dart';
import 'package:flutter_app_new/model/photo.dart';
import 'package:flutter_app_new/screen/photo_detail.dart';
import 'package:flutter_app_new/widget/options_button_span.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class AlbumHomePage extends StatefulWidget {
  String _listImageUrl;
  String _topic;
  AlbumHomePage(this._listImageUrl);

  @override
  State<StatefulWidget> createState() => _AlbumPageState(_listImageUrl);
}

class _AlbumPageState extends State<AlbumHomePage> with WidgetsBindingObserver, TickerProviderStateMixin {
  ScrollController _scrollController;
  bool _isLoadingMore = false;
  String listImageUrl;
  BuildContext blocContext;
  AnimationController _lottieController;

  _AlbumPageState(this.listImageUrl) {
    _scrollController = new ScrollController();
    _scrollController.addListener(_onScroll);
    _lottieController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AlbumBloc(listImageUrl: listImageUrl),
        child: SafeArea(
          child: Scaffold(
            body: BlocBuilder<AlbumBloc, List<Photo>>(builder: (context, listImg) {
              blocContext = context;
              _isLoadingMore = false;
              if (listImg == null) {
                return Container(
                  color: CommonColor.primaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset("assets/lottie_loading.json",
                        controller: _lottieController,
                        onLoaded: (composition) {
                          _lottieController
                            ..duration = composition.duration
                            ..repeat();
                        },
                      ),
                      RichText(
                        text: TextSpan(
                            text: S.current.give_a_cond,
                            style: CommonStyle.textStyleCustom(
                                size: 24.0
                            )
                        ),
                      ),
                      SizedBox(height: 100,)
                    ],
                  ),
                );
              }
              List<Photo> data = listImg;
              if(data?.length == 0)
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: CommonColor.primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10,),
                      Image.asset(
                        "assets/oops.png",
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(height: SizeConfig.verticalSize(5),),
                      RichText(
                        text: TextSpan(
                            text: "Oops",
                            style: CommonStyle.textStyleCustom(
                              size: 24.0,
                            )
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: SizeConfig.verticalSize(2),),
                      RichText(
                        text: TextSpan(
                          text: S.current.empty_title,
                          style: CommonStyle.textStyleCustom(
                            size: 16.0,
                            weight: FontWeight.normal
                          )
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: SizeConfig.verticalSize(3),),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child:  Container(
                            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                color: Colors.grey[200].withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(child: RichText(
                                  text: TextSpan(
                                      text: S.current.try_again,
                                      style: CommonStyle.titleTextStyle
                                  ),
                                )),
                                SizedBox(width: 5,),
                                Flexible(child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 30.0,
                                ),)
                              ],
                            )
                        ),
                      )
                    ],
                  ),
                );
              return Column(
                children: [
                  Expanded(
                      child: Stack(
                        children: [
                          CustomScrollView(
                            physics: BouncingScrollPhysics(),
                            controller: _scrollController,
                            slivers: [
                              CupertinoSliverRefreshControl(
                                onRefresh: () {
                                  context.read<AlbumBloc>().add(AlbumEvent.REFRESH);
                                  return;
                                },
                              ),
                              SliverPadding(
                                padding: EdgeInsets.all(0),
                                sliver: SliverGrid.count(
                                    crossAxisCount: 2,
                                    children: List.generate(data.length, (index) {
                                      return Padding(
                                          padding: EdgeInsets.only(
                                              left: index % 2 == 0 ? 10 : 5,
                                              right: index % 2 == 0 ? 5 : 10,
                                              top: 10),
                                          child: _buildItemImage(data[index]));
                                    })),
                              ),
                              SliverToBoxAdapter(
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 16),
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              );
            }),
          ),
        )
    );
  }

  Widget _buildItemImage(Photo photo) {
    String imgPath =
        photo.liked ? "assets/heart_solid.svg" : "assets/heart_empty.svg";
    return GestureDetector(
        onTap: () {
          _onClickImageItem(photo);
        },
        child: Stack(
          children: [
            Align(
              child: ClipRRect(
                  borderRadius: new BorderRadius.all(Radius.circular(10)),
                  child: Center(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/img_loading.gif',
                      image: photo.src.tiny,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    ),
                  )),
            ),
            Align(
              child: GestureDetector(
                onTap: () {
                  photo.liked = !photo.liked;
                  setState(() {
                    imgPath = photo.liked
                        ? "assets/heart_solid.svg"
                        : "assets/heart_empty.svg";
                  });
                  FavouritePhotoObserve.of().likeImage(photo, photo.liked);
                  //FavouritePhotoObserve.of().add(PhotoFavouriteEvent.LOAD);
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
        ));
  }

  void _onClickImageItem(Photo photo) {
    NavigatorGlobal.pushPhotoDetailPage(context, photo);
  }

  void _onScroll() {
    if (!_isLoadingMore &&
        _scrollController.position.pixels >
            _scrollController.position.maxScrollExtent - 100) {
      _isLoadingMore = true;
      //Load more
      blocContext?.read<AlbumBloc>()?.add(AlbumEvent.LOAD_MORE);
    }
  }

  List<Widget> buildListHorizontalItem() {
    return [
      _buildItemBottom("Animal"),
      _buildItemBottom("Nature"),
      _buildItemBottom("Flutter"),
      _buildItemBottom("Animal"),
      _buildItemBottom("Nature"),
      _buildItemBottom("Flutter"),
      _buildItemBottom("Animal"),
      _buildItemBottom("Nature"),
      _buildItemBottom("Flutter"),
    ];
  }

  Widget _buildItemBottom(String title){
    return Padding(
      padding: EdgeInsets.only(
        left: 10,
        top: 10,
        bottom: 10
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.lightBlue[500],
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: RichText(
              text: TextSpan(
                  text: title
              ),
            ),
          ),
        )
      ),
    );
  }
}
