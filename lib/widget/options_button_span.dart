import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OptionButtonSpan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OptionButtonSpanState();
}

class _OptionButtonSpanState extends State<OptionButtonSpan>{

  double opacityChildWidget = 0;
  bool isShowingMenu = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    topLeft: BorderRadius.circular(100).topLeft
                ),
              ),
              child: Stack(
                children: [
                  AnimatedOpacity(
                    opacity: isShowingMenu?1.0:0.0,
                    duration: Duration(milliseconds: 300),
                    child: Align(
                      alignment: Alignment(0.9, -0.6),
                      child: FloatingActionButton(
                        backgroundColor: Colors.grey,
                        onPressed: _onImageButtonClicked,
                        child: Icon(
                          Icons.image,
                          color: Colors.white,
                        ),
                        heroTag: null,
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: isShowingMenu?1.0:0.0,
                    duration: Duration(milliseconds: 300),
                    child: Align(
                      alignment: Alignment(-0.2, -0.2),
                      child: FloatingActionButton(
                        onPressed: _onVideoButtonClicked,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.video_collection,
                          color: Colors.white,
                        ),
                        heroTag: null,
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: isShowingMenu?1.0:0.0,
                    duration: Duration(milliseconds: 300),
                    child: Align(
                      alignment: Alignment(-0.6, 0.9),
                      child: FloatingActionButton(
                        onPressed: _onMoreButtonClicked,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ),
                        heroTag: null,
                      ),
                    ),
                  ),
                  Align(
                    child: FloatingActionButton(
                      backgroundColor: Colors.lightBlue[500],
                      child: Container(
                        child: Icon(
                          Icons.image
                        ),
                      ),
                      heroTag: null,
                      onPressed: _onMainButtonClicked,
                    ),
                    alignment: Alignment(0.7,0.7),
                  ),
                ],
              )
          ),
        ),
      ],
    );
  }

  void _onImageButtonClicked(){

  }

  void _onVideoButtonClicked(){

  }

  void _onMoreButtonClicked(){

  }

  void _onMainButtonClicked(){
    setState(() {
      isShowingMenu = !isShowingMenu;
    });
  }

}