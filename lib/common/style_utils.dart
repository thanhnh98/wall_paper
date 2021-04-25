import 'package:flutter/cupertino.dart';

class CommonStyle{

  static final double small_text_size = 14.0;
  static final double normal_text_size = 16.0;
  static final double large_text_size = 20.0;
  static final double larger_text_size = 24.0;
  static final double extra_text_size = 28.0;
  static final double super_extra_text_size = 32.0;

  static final TextStyle normalTextStyle = TextStyle(
    fontFamily: 'SourceSans Pro',
    fontSize: normal_text_size,
    fontWeight: FontWeight.normal,
    height: 1.15,
    color: Color(0xFFFFFFFF),
  );

  static final TextStyle smallTextStyle = TextStyle(
    fontFamily: 'SourceSans Pro',
    fontSize: normal_text_size,
    fontWeight: FontWeight.normal,
    height: 1.15,
    color: Color(0xFFFFFFFF),
  );

  static final TextStyle normalTextStyleBold = TextStyle(
    fontFamily: 'SourceSans Pro',
    fontSize: normal_text_size,
    fontWeight: FontWeight.bold,
    height: 1.15,
    color: Color(0xFFFFFFFF),
  );

  static TextStyle textStyleCustom({dynamic size, dynamic weight, dynamic height, dynamic color, dynamic fontStyle}) {
    return TextStyle(
      fontFamily: 'SourceSans Pro',
      fontSize: size??normal_text_size,
      fontWeight: weight??FontWeight.bold,
      height: height??1.15,
      color: color??Color(0xFFFFFFFF),
      fontStyle: fontStyle??FontStyle.normal,
    );
  }

  static final TextStyle titleTextStyle = TextStyle(
    fontFamily: 'SourceSans Pro',
    fontSize: large_text_size,
    fontWeight: FontWeight.bold,
    height: 1.15,
    color: Color(0xFFFFFFFF),
  );

  static final TextStyle titleTextStyleBlack = TextStyle(
    fontFamily: 'SourceSans Pro',
    fontSize: large_text_size,
    fontWeight: FontWeight.bold,
    height: 1.15,
    color: Color(0xFF333333),
  );

}