class CartModel {
  static const ID = 'id';
  static const PRODUCT_ID = 'productId';
  static const IMAGES = 'image';
  static const NAME = 'name';
  static const PRICE = 'price';
  static const SIZE = 'size';
  static const DELIVERY = 'delivery';
  static const SHOPNAME = 'shopName';

  String _id;
  String _productId;
  String _image;
  String _name;
  double _price;
  String _sizes;
  String _delivery;
  String _shopName;

  String get id => _id;
  String get images => _image;
  String get name => _name;
  double get price => _price;
  String get sizes => _sizes;
  String get delivery => _delivery;
  String get shopName => _shopName;
  String get productId => _productId;

  CartModel.fromMap(Map data) {
    _id = data[ID];
    _productId = data[PRODUCT_ID];
    _image = data[IMAGES];
    _name = data[NAME];
    _price = data[PRICE];
    _sizes = data[SIZE];
    _delivery = data[DELIVERY];
    _shopName = data[SHOPNAME];
  }

  Map toMap() => {
        ID: _id,
        PRODUCT_ID: _productId,
        IMAGES: _image,
        NAME: _name,
        PRICE: _price,
        SIZE: _sizes,
        DELIVERY: _delivery,
        SHOPNAME: _shopName
      };
}
