import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_new/bloc/video/VideoBloc.dart';
import 'package:flutter_app_new/bloc/video/VideoEvent.dart';
import 'package:flutter_app_new/bloc/video/VideoScreenState.dart';
import 'package:flutter_app_new/common/navigator_custom.dart';
import 'package:flutter_app_new/common/style_utils.dart';
import 'package:flutter_app_new/model/album.dart';
import 'package:flutter_app_new/model/videos/video.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _VideoPageState();

}

class _VideoPageState extends State<VideoPage>{
  ScrollController _scrollController;
  bool _isLoadingMore = false;
  BuildContext blocContext;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider(
          create: (context) => VideoBloc(),
          child: Scaffold(
            body: BlocBuilder<VideoBloc, VideoScreenState>(
              builder: (context, state){
                blocContext??=context;
                if(state != null && state.event == VideoEvent.COMPLETED) {
                  _isLoadingMore = false;
                  List<VideoModel> listVideos = state.data.videos;
                  if(listVideos == null || listVideos.length == 0)
                    return _buildListVideoEmpty();

                  return CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    controller: _scrollController,
                    slivers: [
                      CupertinoSliverRefreshControl(
                        onRefresh: () {
                          blocContext.read<VideoBloc>().add(VideoEvent.LOAD);
                          return;
                        },
                      ),
                      SliverGrid.count(
                        crossAxisCount: 2,
                        children: List.generate(listVideos.length, (index){
                          return _buildItemVideo(listVideos[index]);
                        }),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.only(bottom: 16),
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ]
                  );
                }

                return Container();
              },
            ),
          ),
        )
    );
  }
  Widget _buildListVideoEmpty() {
    return Container();
  }

  Widget _buildItemVideo(VideoModel video){
    return GestureDetector(
      onTap: (){
        NavigatorGlobal.pushVideoDetailPage(context, video);
      },
      child: Container(
        width: 50,
        height: 50,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Stack(
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      placeholder: "",
                      image: video.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment(0.9, 0.9),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: RichText(
                        text: TextSpan(
                            text: video.video_files[0].file_type,
                            style: CommonStyle.textStyleCustom(
                                size: 14.0,
                                fontStyle: FontStyle.italic
                            )
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8)
                      ),
                    )
                )
              ],
            )
        ),
      ),
    );
  }

  void _onScroll() {
    if (!_isLoadingMore &&
        _scrollController.position.pixels >
            _scrollController.position.maxScrollExtent - 100) {
      _isLoadingMore = true;
      //Load more
      blocContext?.read<VideoBloc>()?.add(VideoEvent.LOAD_MORE);
    }
  }
}
