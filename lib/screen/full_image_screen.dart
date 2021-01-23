import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_new/bloc/photo/photo_detail_bloc.dart';
import 'package:flutter_app_new/dialog/wallpaper_location_picker_dialog.dart';
import 'package:flutter_app_new/model/photo.dart';
import 'package:flutter_app_new/widget/download_progress_provider.dart';
import 'package:flutter_app_new/widget/processing_widget.dart';
import 'package:flutter_svg/svg.dart';

class ImageFullPage extends StatefulWidget {
  Photo _photo;
  ImageFullPage(this._photo);

  @override
  State<StatefulWidget> createState() => _ImageFullPageState(_photo);
}

class _ImageFullPageState extends State<ImageFullPage> {
  double itemSize = 50;
  PhotoDetailBloc _photoBloc;
  Photo _photo;
  bool _isImageTaped = false;

  _ImageFullPageState(this._photo) {
    _photoBloc = DownloadProgressProvider.of(context, photo: _photo);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,

          child: InteractiveViewer(
            child: _buildImageView(),
          )
        ),
        Align(
          child: GestureDetector(
              child: AnimatedOpacity(
                opacity: _isImageTaped ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.black38.withOpacity(0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: Center(
                            child: _buildIconDownload(),
                          )),
                          Expanded(child: Center(
                            child: _buildIconSetBackground(context),
                          ))
                        ],
                      ),
                    ),
                  )
              )
          ),
          alignment: Alignment.bottomCenter,
        )
      ],
    );
  }

  Widget _buildImageView() {
    return GestureDetector(
      onTap: (){
        setState(() {
          this._isImageTaped = !this._isImageTaped;
        });
      },
      child: FadeInImage.assetNetwork(
        placeholder: "assets/img_loading_2.gif",
        image: _photo.src.original,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget _buildIconDownload() {
    return DownloadProgressProvider(
        data: _photo,
        child: ProcessingWidget(
          child: GestureDetector(
              onTap: () {
                _photoBloc.downloadImage(_photo.src.original);
              },
              child: _buildIcon(
                Icon(
                  Icons.arrow_downward_outlined,
                  size: 50,
                  color: Colors.white70,
                ),
              )),
          processingStream: _photoBloc.imageDownloadedPercent,
        )
    );
  }

  Widget _buildIconSetBackground(context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            child: WallpaperDialog(_photo));
      },
      child: _buildIcon(
          Icon(
            Icons.photo,
            size: 50,
            color: Colors.white70,
          )
      ),
    );
  }

  Widget _buildIcon(Widget icon) {
    return Padding(padding: EdgeInsets.all(4.0), child: Center(child: icon));
  }
}