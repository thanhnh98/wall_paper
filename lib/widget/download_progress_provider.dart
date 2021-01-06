import 'package:flutter/widgets.dart';
import 'package:flutter_app_new/bloc/photo/photo_detail_bloc.dart';
import 'package:flutter_app_new/model/photo.dart';

// ignore: must_be_immutable
class DownloadProgressProvider extends InheritedWidget{
  // ignore: close_sinks
  static PhotoDetailBloc _photoBloc;
  static Photo _photo;
  DownloadProgressProvider({
        Key key,
        @required Photo data,
        @required Widget child
  }): super(key: key, child: child){
    _photo = data;
  }



  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static PhotoDetailBloc of(BuildContext context,{Photo photo}) => _photoBloc??=PhotoDetailBloc(_photo);

}