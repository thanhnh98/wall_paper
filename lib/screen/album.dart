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
  AlbumBloc _bloc;

  AlbumHomePage(albumBloc) {
    this._bloc = albumBloc;
  }

  @override
  State<StatefulWidget> createState() => _AlbumPageState(_bloc);
}

class _AlbumPageState extends State<AlbumHomePage> with WidgetsBindingObserver {
  AlbumBloc _albumBloc;
  ScrollController _scrollController;
  static const double _endReachedThreshold = 200;
  bool _isLoadingMore = false;

  _AlbumPageState(AlbumBloc _bloc) {
    this._albumBloc = _bloc;
    _scrollController = new ScrollController();
    _scrollController.addListener(_onScroll);
    _albumBloc.add(AlbumEvent.LOAD);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AlbumBloc, List<Photo>>(builder: (context, listImg) {
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
                    Align(
                      alignment: Alignment.bottomRight,
                      child: OptionButtonSpan(),
                    )
                  ],
                )),
          ],
        );
      }),
    );
  }

  Widget _buildBottomBar(){
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.only(
              topLeft: BorderRadius.circular(4).topLeft,
              topRight: BorderRadius.circular(4).topRight
          )
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: buildListHorizontalItem(),
        ),
      ),
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
                  _albumBloc.likeImage(photo.id, photo.liked);
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
      _albumBloc.add(AlbumEvent.LOAD_MORE);
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
