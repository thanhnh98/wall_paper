import 'package:bloc/bloc.dart';
import 'package:flutter_app_new/bloc/video/VideoEvent.dart';
import 'package:flutter_app_new/bloc/video/VideoScreenState.dart';
import 'package:flutter_app_new/model/album.dart';
import 'package:flutter_app_new/model/videos/video.dart';
import 'package:flutter_app_new/repository/videos_repository.dart';

class VideoBloc extends Bloc<VideoEvent, VideoScreenState>{
  VideoBloc() : super(null){
    add(VideoEvent.LOAD);
  }

  String urlListPhotos = "https://api.pexels.com/videos/popular?per_page=80";
  int currentPage = 1;
  AlbumModel currentAlbum;

  @override
  Stream<VideoScreenState> mapEventToState(VideoEvent event) async*{
    switch(event){
      case VideoEvent.LOAD:
        currentPage = 1;
        currentAlbum = await VideoRepository().getListVideosPopular(urlListPhotos + "&page=$currentPage");
        print("LOAD VIDEO -> ${urlListPhotos + "&page=${currentPage}"}");
        yield VideoScreenState(event: VideoEvent.COMPLETED, data: currentAlbum);
        break;
      case VideoEvent.LOAD_MORE:
        AlbumModel album = await VideoRepository().getListVideosPopular(urlListPhotos + "&page=${++currentPage}");
        print("LOAD VIDEO MORE -> ${urlListPhotos + "&page=${currentPage}"}");
        currentAlbum.videos.addAll(album.videos);
        print("video ---------> ${currentAlbum.videos.length}");
        yield VideoScreenState(event: VideoEvent.COMPLETED, data: currentAlbum.clone());
        break;
    }
  }

}