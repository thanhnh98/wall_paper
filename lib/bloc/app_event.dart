abstract class AppEvent{}

class OpenHomePageEvent extends AppEvent{

}

class OpenPhotoDetailEvent extends AppEvent{
  int photoId;
  OpenPhotoDetailEvent(this.photoId);
}