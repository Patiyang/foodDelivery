import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShopModel {
  static const SHOPDESCRIPTION = 'description';
  static const ID = 'id';
  static const BACKGROUNDIMAGE = 'backgroundImage';
  static const NAME = 'shopName';
  static const LOCATION = 'location';
  static const PROFILEiMAGE = 'profileImage';

  String _description;
  String _id;
  String _backgroundImage;
  String _name;
  String _location;
  String _profileImage;

  ShopModel.fromSnapshot(DocumentSnapshot snap) {
    Map data = snap.data;
    _description = data[SHOPDESCRIPTION];
    _id = data[ID];
    _backgroundImage = data[BACKGROUNDIMAGE];
    _name = data[NAME];
    _location = data[LOCATION];
    _profileImage = data[PROFILEiMAGE];
  }
  String get description => _description;
  String get id => _id;
  String get backgroundImage => _backgroundImage;
  String get name => _name;
  String get location => _location;
  String get profileImage => _profileImage;
}
