import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsModel {
  static const BRAND = 'brand';
  static const CATEGORY = 'category';
  static const DESCRIPTION = 'description';
  static const ID = 'id';
  static const IMAGES = 'images';
  static const NAME = 'name';
  static const PRICE = 'price';
  static const QUANTITY = 'quantity';
  static const SIZES = 'size';
  static const STATUS = 'status';
  static const DELIVERY = 'delivery';
  static const LOCATION = 'location';
  static const SHOPNAME = 'shopName';

  String _brand;
  String _category;
  String _description;
  String _id;
  List _images;
  String _name;
  double _price;
  int _quantity;
  List _sizes;
  String _status;
  String _delivery;
  String _location;
  String _shopName;

  ProductsModel.fromSnapshot(DocumentSnapshot snap) {
    Map data = snap.data;
    _brand = data[BRAND];
    _category = data[CATEGORY];
    _description = data[DESCRIPTION];
    _id = data[ID];
    _images = data[IMAGES];
    _name = data[NAME];
    _price = data[PRICE];
    _quantity = data[QUANTITY];
    _sizes = data[SIZES];
    _status = data[STATUS];
    _delivery = data[DELIVERY];
    _location = data[LOCATION];
    _shopName = data[SHOPNAME];
  }
  String get brand => _brand;
  String get category => _category;
  String get description => _description;
  String get id => _id;
  List get images => _images;
  String get name => _name;
  double get price => _price;
  int get quantity => _quantity;
  List get sizes => _sizes;
  String get status => _status;
  String get delivery => _delivery;
  String get location => _location;
  String get shopName => _shopName;
}
