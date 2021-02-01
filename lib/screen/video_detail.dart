import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_new/common/color_utils.dart';
import 'package:flutter_app_new/common/sized_config.dart';
import 'package:flutter_app_new/common/style_utils.dart';
import 'package:flutter_app_new/model/videos/video.dart';
import 'package:video_player/video_player.dart';

class VideoDetailPage extends StatefulWidget{
  VideoModel video;
  VideoDetailPage(this.video);

  @override
  State<StatefulWidget> createState() => _ViewDetailPageState(this.video);
}

class _ViewDetailPageState extends State<VideoDetailPage>{
  VideoPlayerController _controller;
  VideoModel video;

  _ViewDetailPageState(this.video);

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(video.video_files[0].link)
    ..setLooping(true)
    ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          print("--------> hehe");
        });
      })
    ..play();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.black,
              width: SizeConfig.horizontalSize(100),
              height: SizeConfig.verticalSize(100),
              child: InteractiveViewer(
                minScale: 1.25,
                maxScale: 1.25,
                scaleEnabled: false,
                child: Container(
                  child: Center(
                    child: _controller.value.initialized
                        ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                        : FadeInImage.assetNetwork(
                      placeholder: "assets/img_loading_2.gif",
                      image: video.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            VideoProgressIndicator(
                _controller,
                allowScrubbing: true
            ),
            FlatButton(
              onPressed: () {
                if(_controller.value.isPlaying)
                  _controller.pause();
                else
                  _controller.play();

              },
              child: RichText(
                text: TextSpan(
                    text: "Click me",
                    style: CommonStyle.normalTextStyle
                ),
              ),
            )
          ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}