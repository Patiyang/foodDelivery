import 'package:flutter/material.dart';

class FoodList {
  final String name;
  final String hotelName;
  final String image;
  final String location;
  final String deliveryTime;
  final String distance;
  final String description;

  FoodList({
    @required this.hotelName,
    @required this.name,
    @required this.image,
    @required this.location,
    @required this.deliveryTime,
    @required this.distance,
    this.description,
  });
}
