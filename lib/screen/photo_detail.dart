import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_new/bloc/observe/favourite_photo_observe.dart';
import 'package:flutter_app_new/bloc/photo/photo_detail_bloc.dart';
import 'package:flutter_app_new/common/style_utils.dart';
import 'package:flutter_app_new/dialog/wallpaper_location_picker_dialog.dart';
import 'package:flutter_app_new/generated/l10n.dart';
import 'package:flutter_app_new/model/photo.dart';
import 'package:flutter_app_new/widget/download_progress_provider.dart';
import 'package:flutter_app_new/widget/processing_widget.dart';
import 'package:flutter_svg/svg.dart';

import 'full_image_screen.dart';

class PhotoDetailPage extends StatefulWidget {
  Photo _photo;
  bool isThisPhotoDownloaded = false;

  PhotoDetailPage(Photo photo) {
    this._photo = photo;
  }

  @override
  State<StatefulWidget> createState() => _PhotoDetailState(_photo);
}

class _PhotoDetailState extends State<PhotoDetailPage> {
  Photo _photo;
  PhotoDetailBloc _photoBloc;
  double itemSize = 40;

  _PhotoDetailState(photo) {
    this._photo = photo;
    _photoBloc = DownloadProgressProvider.of(context, photo: _photo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildImage(),
                SizedBox(
                  height: 5,
                ),
                _buildOptionsBar(),
                _buildBottomInfo()
              ],
            ),
          )),
    );
  }

  Widget _buildImage() {
    return GestureDetector(
      onTap: () {
        _openFullScreen();
      },
      child: FadeInImage.assetNetwork(
        placeholder: '',
        image: _photo.src.portrait,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),
    );
  }

  Widget _buildBottomInfo() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.grey),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(S.current.info),
                  RichText(
                      text: TextSpan(
                          text: "(${_photo.width}x${_photo.height})",
                          style: CommonStyle.textStyleCustom(
                            size: 14.0,
                            weight: FontWeight.normal,
                            fontStyle: FontStyle.italic
                          )
                      )
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildPhotographerInfo(),
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return RichText(
        text: TextSpan(text: title, style: CommonStyle.titleTextStyle));
  }

  Widget _buildOptionsBar() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.grey),
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(S.current.options),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        _buildIconDownload(),
                        SizedBox(
                          width: 15,
                        ),
                        _buildIconZoom(),
                        SizedBox(width: 15,),
                        _buildIconSetBackground(),
                        SizedBox(width: 15,),
                        _buildIconFavourite()
                      ],
                    ),
                  ],
                ))),
      ),
    );
  }

  Widget _buildIconDownload() {
    return DownloadProgressProvider(
        data: _photo,
        child: ProcessingWidget(
          processingStream: _photoBloc.imageDownloadedPercent,
          child: GestureDetector(
              onTap: () {
                _photoBloc.downloadImage(_photo.src.original);
              },
              child: _buildIcon(
                Icon(
                  Icons.arrow_downward_outlined,
                  size: 24,
                ),
              )
          ),
        )
    );
  }

  Widget _buildIconZoom() {
    return GestureDetector(
        onTap: () {
          _openFullScreen();
        },
        child: _buildIcon(Icon(
          Icons.zoom_out_map,
          size: 24,
        )));
  }

  Widget _buildIconSetBackground(){
    return GestureDetector(
      onTap: (){
        showDialog(
            context: context,
            child: WallpaperDialog(_photo));
      },
      child: _buildIcon(
        Icon(
          Icons.photo,
          size: 24,
        )
      ),
    );
  }

  Widget _buildIconFavourite(){
    String imgPath = _photo.liked
        ? "assets/heart_solid.svg"
        : "assets/heart_empty.svg";
    return GestureDetector(
      onTap: (){
        setState(() {
          _photo.liked = !_photo.liked;
          FavouritePhotoObserve.of().likeImage(_photo, _photo.liked);
        });
      },
      child: _buildIcon(
        SvgPicture.asset(imgPath)
      ),
    );
  }

  Widget _buildIcon(Widget icon) {
    return Container(
        width: itemSize,
        height: itemSize,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(4)),
        child:
            Padding(padding: EdgeInsets.all(4.0), child: Center(child: icon)));
  }

  Widget _buildPhotographerInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(text: TextSpan(text: S.current.photo_by)),
            Flexible(
                child: RichText(
              text: TextSpan(
                  text: _photo.photographer,
                  style: CommonStyle.normalTextStyleBold),
            ))
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            RichText(text: TextSpan(text: S.current.contact)),
            Flexible(
              child: GestureDetector(
                onTap: () {
                  _photoBloc.openUrl(_photo.photographer_url);
                },
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  text: TextSpan(
                      text: _photo.photographer_url,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      )),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  void _openFullScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ImageFullPage(_photo)));
  }
}
