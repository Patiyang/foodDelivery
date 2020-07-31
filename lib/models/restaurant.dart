import 'package:flutter/material.dart';

class RestaurantList {
  String image;
  String hotelName;
  String address;
  bool delivery;
  String deliveryPrice;

  RestaurantList({@required this.image, @required this.hotelName, @required this.address, this.delivery, this.deliveryPrice});
}
