import 'package:flutter_app_new/generated/l10n.dart';
import 'package:flutter_app_new/model/horizontal_landing_item.dart';

class Constant{
  static int _width = 400;
  static int _height = 600;
  static int _perpage = 80;
  static List<HorizontalLandingItemModel> getListTopicLanding() => [
    HorizontalLandingItemModel(
        S.current.curated,
        "https://images.pexels.com/photos/5914065/pexels-photo-5914065.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/${"curated"}?per_page=$_perpage"),
    HorizontalLandingItemModel(
        S.current.animal,
        "https://images.pexels.com/photos/41315/africa-african-animal-cat-41315.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"animal"}&per_page=$_perpage"),
    HorizontalLandingItemModel(
        S.current.nature,
        "https://images.pexels.com/photos/33041/antelope-canyon-lower-canyon-arizona.jpg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"nature"}&per_page=$_perpage"),
    HorizontalLandingItemModel(
        S.current.school,
        "https://images.pexels.com/photos/2681319/pexels-photo-2681319.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"high+school"}&per_page=$_perpage"),
    HorizontalLandingItemModel(
        S.current.text,
        "https://images.pexels.com/photos/261763/pexels-photo-261763.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"text"}&per_page=$_perpage"),
    HorizontalLandingItemModel(
        S.current.travel,
        "https://images.pexels.com/photos/1051075/pexels-photo-1051075.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"travel"}&per_page=$_perpage"),
    HorizontalLandingItemModel(
        S.current.traffic,
        "https://images.pexels.com/photos/7674/pexels-photo.jpg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"traffic"}&per_page=$_perpage"),
    HorizontalLandingItemModel(
        S.current.beauty,
        "https://images.pexels.com/photos/1372134/pexels-photo-1372134.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"female"}&per_page=$_perpage"),
    HorizontalLandingItemModel(
        S.current.random,
        "https://images.pexels.com/photos/572741/pexels-photo-572741.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"country"}&per_page=$_perpage"),
  ];


  static List<HorizontalLandingItemModel> getListTopicSuggestSearchPage() => [
    HorizontalLandingItemModel(
        S.current.curated,
        "https://images.pexels.com/photos/5914065/pexels-photo-5914065.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/${"curated"}?per_page=$_perpage"),
    HorizontalLandingItemModel(
        S.current.animal,
        "https://images.pexels.com/photos/41315/africa-african-animal-cat-41315.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"animal"}&per_page=$_perpage"),
    HorizontalLandingItemModel(
        S.current.nature,
        "https://images.pexels.com/photos/33041/antelope-canyon-lower-canyon-arizona.jpg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"nature"}&per_page=$_perpage"),
    HorizontalLandingItemModel(
        S.current.school,
        "https://images.pexels.com/photos/2681319/pexels-photo-2681319.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"high+school"}&per_page=$_perpage"),
    HorizontalLandingItemModel(
        S.current.text,
        "https://images.pexels.com/photos/261763/pexels-photo-261763.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"text"}&per_page=$_perpage"),
    HorizontalLandingItemModel(
        S.current.travel,
        "https://images.pexels.com/photos/1051075/pexels-photo-1051075.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"travel"}&per_page=$_perpage"),
    HorizontalLandingItemModel(
        S.current.traffic,
        "https://images.pexels.com/photos/7674/pexels-photo.jpg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"traffic"}&per_page=$_perpage"),
    HorizontalLandingItemModel(
        S.current.beauty,
        "https://images.pexels.com/photos/1372134/pexels-photo-1372134.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"beautiful-girl"}&per_page=$_perpage"),
    HorizontalLandingItemModel(
        S.current.random,
        "https://images.pexels.com/photos/572741/pexels-photo-572741.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width",
        "https://api.pexels.com/v1/search?query=${"country"}&per_page=$_perpage"),
  ];

  static List<String> listKeyWord() => [
    "Korea",
    "animal",
    "sea",
    "business",
    "fine art",
    "flower",
    "sky",
    "nature",
    "medical",
    "hospital",
    "girl",
    "man",
    "boy",
    "robot",
    "math",
    "macbook",
    "world-travel",
    "sport",
    "industry",
    "teacher",
    "student",
    "father",
    "family",
    "vietnamese",
    "japan",
    "american",
    "world",
    "mommy",
    "android",
    "robotic",
    "fishing",
    "shark",
    "phone",
    "plant",
    "people",
    "monkey",
    "cat",
    "pretty",
    "illustration",
    "lifestyle",
    "city"
  ];


}