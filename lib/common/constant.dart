import 'package:flutter_app_new/model/horizontal_landing_item.dart';

class Constant{
  static int _width = 400;
  static int _height = 600;
  static List<HorizontalLandingItemModel> getListTopicLanding() => [
    HorizontalLandingItemModel("Animal", "https://images.pexels.com/photos/41315/africa-african-animal-cat-41315.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width"),
    HorizontalLandingItemModel("Nature", "https://images.pexels.com/photos/33041/antelope-canyon-lower-canyon-arizona.jpg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width"),
    HorizontalLandingItemModel("School", "https://images.pexels.com/photos/2681319/pexels-photo-2681319.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width"),
    HorizontalLandingItemModel("Text", "https://images.pexels.com/photos/261763/pexels-photo-261763.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width"),
    HorizontalLandingItemModel("Travel", "https://images.pexels.com/photos/1051075/pexels-photo-1051075.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width"),
    HorizontalLandingItemModel("Traffic", "https://images.pexels.com/photos/7674/pexels-photo.jpg?auto=compress&cs=tinysrgb&fit=crop&h=$_height&w=$_width"),
  ];
}