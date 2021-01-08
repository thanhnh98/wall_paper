import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_new/bloc/album/album_bloc.dart';
import 'package:flutter_app_new/bloc/album/album_event.dart';
import 'package:flutter_app_new/model/photo.dart';
import 'package:flutter_app_new/screen/photo_detail.dart';
import 'package:flutter_app_new/widget/options_button_span.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AlbumHomePage extends StatefulWidget {
  String _listImageUrl;
  AlbumHomePage(this._listImageUrl);

  @override
  State<StatefulWidget> createState() => _AlbumPageState(_listImageUrl);
}

class _AlbumPageState extends State<AlbumHomePage> with WidgetsBindingObserver {
  ScrollController _scrollController;
  bool _isLoadingMore = false;
  String listImageUrl;
  BuildContext blocContext;
  _AlbumPageState(this.listImageUrl) {
    _scrollController = new ScrollController();
    _scrollController.addListener(_onScroll);
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
                return Container();
              }
              List<Photo> data = listImg;
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
                                  context.read<AlbumBloc>().add(AlbumEvent.LOAD);
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
                  context.read<AlbumBloc>().likeImage(photo.id, photo.liked);
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
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PhotoDetailPage(photo)));
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
