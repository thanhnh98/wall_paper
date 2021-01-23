import 'package:equatable/equatable.dart';
import 'package:flutter_app_new/bloc/video/VideoEvent.dart';
import 'package:flutter_app_new/model/album.dart';

// ignore: must_be_immutable
class VideoScreenState extends Equatable{
  VideoEvent event;
  AlbumModel data;

  VideoScreenState({this.event, this.data});

  VideoScreenState clone() => VideoScreenState(event: this.event, data: this.data);

  @override
  List<Object> get props => [event, data];
}