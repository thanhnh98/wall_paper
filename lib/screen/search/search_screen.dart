import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_new/bloc/search/search_bloc.dart';
import 'package:flutter_app_new/common/color_utils.dart';
import 'package:flutter_app_new/common/constant.dart';
import 'package:flutter_app_new/common/navigator_custom.dart';
import 'package:flutter_app_new/common/sized_config.dart';
import 'package:flutter_app_new/common/style_utils.dart';
import 'package:flutter_app_new/generated/l10n.dart';
import 'package:flutter_app_new/model/horizontal_landing_item.dart';
import 'package:flutter_app_new/model/photo.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SearchScreenState();

}

class _SearchScreenState extends State<SearchScreen> with TickerProviderStateMixin{
  SearchBloc _searchBloc;
  AnimationController _controller;
  TextEditingController _textController;
  @override
  void initState() {
    super.initState();
    _searchBloc = SearchBloc();
    _searchBloc.getContentSearch().listen((event) {
      NavigatorGlobal.pushAlbumHomePage(context, event.toString());
      _controller?.reset();
    });
    _controller = AnimationController(vsync: this);
    _textController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage("assets/img_vhl_potstrait.jpeg"),
          //   fit: BoxFit.cover
          // )
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CommonColor.primaryColorDark,
              CommonColor.primaryColor
            ]
          )
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: SizeConfig.verticalSize(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          text: S.current.slogan_search,
                          style: CommonStyle.textStyleCustom(
                              size: 30.0,
                              color: Colors.white
                          )
                      ),
                    ),
                  ),
                ],
              )
            ),
            Container(
              height: 60,
              margin: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 35,
                bottom: 15
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.7)),
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(-1, 0),
                      // child: RichText(
                      //   text: TextSpan(
                      //       text: S.current.search,
                      //       style: CommonStyle.textStyleCustom(
                      //           size: 24.0, weight: FontWeight.normal)),
                      // ),
                      child: TextField(
                        controller: _textController,
                        autofocus: true,
                        style: CommonStyle.textStyleCustom(size: 24.0, weight: FontWeight.normal),
                        decoration: InputDecoration.collapsed(
                          hintText: S.current.search,
                          hintStyle: CommonStyle.textStyleCustom(size: 24.0, weight: FontWeight.normal),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        onSubmitted: (s){
                          if (s.isEmpty)
                            return;
                          _searchBloc.handleSearch(s);
                          _controller.repeat();
                        },
                      ),
                    ),
                    Align(
                        alignment: Alignment(1, 0),
                        child: GestureDetector(
                          onTap: (){
                            if(_textController?.text?.isEmpty)
                              return;
                            _searchBloc.handleSearch(_textController?.text);
                            _controller.repeat();
                            FocusScope.of(context).unfocus();
                          },
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 40,
                          ),
                        ))
                  ],
                ),
              ),
            ),
            // Row(
            //   children: [
            //     Flexible(child: RichText(
            //       text: TextSpan(
            //         text: "Đề xuất: ",
            //         style: CommonStyle.textStyleCustom(
            //           weight: FontWeight.normal,
            //           size: 18.0
            //         )
            //       ),
            //     ))
            //   ],
            // ),
            Flexible(
              child: Lottie.asset("assets/finding_image.json",
                  controller: _controller,
                  onLoaded: (composition) {
                    _controller
                      ..duration = composition.duration
                      ..stop();
                  },
                  width: SizeConfig.horizontalSize(100),
                  height: SizeConfig.horizontalSize(100)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItemSingle(HorizontalLandingItemModel item) {
    return GestureDetector(
      onTap: () {
        NavigatorGlobal.pushAlbumHomePage(context, item.url);
      },
      child: Container(
          width: SizeConfig.horizontalSize(20),
          height: SizeConfig.horizontalSize(20),
          margin: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15
              ),
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

}