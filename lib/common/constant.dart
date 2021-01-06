import 'package:flutter_app_new/generated/l10n.dart';
import 'package:flutter_app_new/model/horizontal_landing_item.dart';

class Constant{
  static int _width = 400;
  static int _height = 600;
  static List<HorizontalLandingItemModel> getListTopicLanding() => [
    HorizontalLandingItemModel(
        S.current.curated,
        "https://images.pexels.com/photos/5914065/pexels-photo-5914065.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/${"curated"}?per_page=20"),
    HorizontalLandingItemModel(
        S.current.animal,
        "https://images.pexels.com/photos/41315/africa-african-animal-cat-41315.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"animal"}&per_page=20"),
    HorizontalLandingItemModel(
        S.current.nature,
        "https://images.pexels.com/photos/33041/antelope-canyon-lower-canyon-arizona.jpg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"nature"}&per_page=20"),
    HorizontalLandingItemModel(
        S.current.school,
        "https://images.pexels.com/photos/2681319/pexels-photo-2681319.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"school"}&per_page=20"),
    HorizontalLandingItemModel(
        S.current.text,
        "https://images.pexels.com/photos/261763/pexels-photo-261763.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"text"}&per_page=20"),
    HorizontalLandingItemModel(
        S.current.travel,
        "https://images.pexels.com/photos/1051075/pexels-photo-1051075.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"travel"}&per_page=20"),
    HorizontalLandingItemModel(
        S.current.traffic,
        "https://images.pexels.com/photos/7674/pexels-photo.jpg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"traffic"}&per_page=20"),
  ];
}