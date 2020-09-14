class CartModel {
  static const ID = 'id';
  static const PRODUCT_ID = 'productId';
  static const IMAGE = 'image';
  static const NAME = 'name';
  static const PRICE = 'price';
  static const SIZE = 'size';
  static const DELIVERY = 'delivery';
  static const SHOPNAME = 'shopName';
  static const QUANTITY = 'quantity';
  static const TOTAL = 'cartTotal';

  String _id;
  String _productId;
  String _image;
  String _name;
  double _price;
  String _sizes;
  int _delivery;
  String _shopName;
  int _quantity;
  double _total;

  String get id => _id;
  String get image => _image;
  String get name => _name;
  double get price => _price;
  String get sizes => _sizes;
  int get delivery => _delivery;
  String get shopName => _shopName;
  String get productId => _productId;
  int get quantity => _quantity;
  double get total => _total;

  CartModel.fromMap(Map data) {
    _id = data[ID];
    _productId = data[PRODUCT_ID];
    _image = data[IMAGE];
    _name = data[NAME];
    _price = data[PRICE];
    _sizes = data[SIZE];
    _delivery = data[DELIVERY];
    _shopName = data[SHOPNAME];
    _quantity = data[QUANTITY];
    _total = data[TOTAL];
  }

  Map toMap() => {
        ID: _id,
        PRODUCT_ID: _productId,
        IMAGE: _image,
        NAME: _name,
        PRICE: _price,
        SIZE: _sizes,
        DELIVERY: _delivery,
        SHOPNAME: _shopName,
        QUANTITY: _quantity,
        TOTAL: _total
      };
}
