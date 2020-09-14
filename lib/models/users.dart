import 'package:cloud_firestore/cloud_firestore.dart';
import 'cartProducts.dart';

class UserModel {
  static const PASSWORD = 'password';
  static const ID = "uid";
  static const FIRSTNAME = "firstName";
  static const LASTNAME = "lastName";
  static const EMAIL = "emailAddress";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";
  static const collection = 'users';

  String _firstName;
  String _lastName;
  String _password;
  String _email;
  String _id;
  String _stripeId;
  double _priceSum = 0;
  double totalPerItem = 0;

//  getters
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get id => _id;
  String get stripeId => _stripeId;
  String get password => _password;
  // public variables
  List<CartModel> cart;
  double totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _firstName = snapshot.data[FIRSTNAME];
    _lastName = snapshot.data[LASTNAME];
    _email = snapshot.data[EMAIL];
    _id = snapshot.data[ID];
    _password = snapshot.data[PASSWORD];
    _stripeId = snapshot.data[STRIPE_ID] ?? "";
    cart = _convertCartItems(snapshot.data[CART] ?? []);
    totalCartPrice = snapshot.data[CART] == null ? 0 : getTotalPrice(cart: snapshot.data[CART]);
  }

  List<CartModel> _convertCartItems(List cart) {
    List<CartModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartModel.fromMap(cartItem));
    }
    return convertedCart;
  }

  double getTotalPrice({List cart}) {
    if (cart == null) {
      return 0;
    }
    for (Map cartItem in cart) {
      _priceSum += cartItem[CartModel.TOTAL];
    }

    double total = _priceSum;
    return total;
  }
}
