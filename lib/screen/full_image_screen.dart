import 'package:flutter/cupertino.dart';

class ImageFullPage extends StatelessWidget{
  String _imgUrl;
  ImageFullPage(this._imgUrl);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: FadeInImage.assetNetwork(
        placeholder: "assets/img_loading_2.gif",
        image: _imgUrl,
        fit: BoxFit.cover,
      )
    );
  }

}