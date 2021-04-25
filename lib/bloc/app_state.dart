import 'package:flutter_app_new/model/photo.dart';

abstract class AppState{}

class OpenHomePageState extends AppState{}
class OpenDetailPhotoState extends AppState{
    Photo photo;
    OpenDetailPhotoState(this.photo);
}
