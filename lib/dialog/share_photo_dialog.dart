import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app_new/common/color_utils.dart';
import 'package:flutter_app_new/common/sized_config.dart';
import 'package:flutter_app_new/common/style_utils.dart';
import 'package:flutter_app_new/dialog/base_dialog.dart';
import 'package:flutter_app_new/generated/l10n.dart';
import 'package:flutter_app_new/model/photo.dart';
import 'package:share/share.dart';

class SharePhotoDialog extends StatelessWidget{

  Photo _photo;
  SharePhotoDialog(this._photo);

  @override
  Widget build(BuildContext context) {
    double widthDialog = SizeConfig.horizontalSize(80.0);
    double heightDialog = 400;
    double heightImage = (heightDialog * 60)/100;
    String contentShow = _photo.src.original;
    String contentShare = _photo.src.original + "\n\n" + S.current.download_now + ": https://play.google.com/store/apps/details?id=com.tlife.wall_paper";
    return BaseStateLessDialog(
        Container(
          width: widthDialog,
          height: heightDialog,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                child: FadeInImage.assetNetwork(
                  placeholder: '',
                  image: _photo.src.portrait,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  width: widthDialog,
                  height: heightImage,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: RichText(
                      text: TextSpan(
                        text: contentShow,
                        style: CommonStyle.textStyleCustom(
                          color: CommonColor.black_33,
                          weight: FontWeight.normal
                        ),
                      )
                  ),
                  decoration: BoxDecoration(
                    color: CommonColor.gray_eb,
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: (){
                        Share.share(contentShare).then((value) => Navigator.pop(context));

                      },
                      child: RichText(
                          text: TextSpan(
                            text: S.current.share_now,
                            style: CommonStyle.textStyleCustom(
                              color: CommonColor.white,
                            ),
                          )
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: CommonColor.primaryColor,
                        padding: EdgeInsets.all(10),
                      ),
                  )
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: CommonColor.white,
            borderRadius: BorderRadius.circular(10)
          ),
        )
    );
  }


}