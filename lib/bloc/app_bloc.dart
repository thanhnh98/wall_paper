import 'package:bloc/bloc.dart';
import 'package:flutter_app_new/bloc/app_event.dart';
import 'package:flutter_app_new/bloc/app_state.dart';
import 'package:flutter_app_new/model/photo.dart';

class AppBloc extends Bloc<AppEvent, AppState>{
  AppBloc() : super(null);

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
      if (event is OpenHomePageEvent) {
        yield OpenHomePageState();
        return;
      }

      if (event is OpenPhotoDetailEvent){
        Photo photo = await getPhotoById(event.photoId);
        yield OpenDetailPhotoState(photo);
        return;
      }
  }

  Future<Photo> getPhotoById(int photoId){
    return Future.value(Photo());
  }
}