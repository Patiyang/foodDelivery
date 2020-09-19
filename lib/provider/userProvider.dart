import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodDelivery/models/cartProducts.dart';
import 'package:foodDelivery/models/products.dart';
import 'package:foodDelivery/models/users.dart';
import 'package:foodDelivery/service/userService.dart';
import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  UserService _userServices = UserService();
  // OrderServices _orderServices = OrderServices();

  UserModel _userModel;

//  getter
  UserModel get userModel => _userModel;

  Status get status => _status;

  FirebaseUser get user => _user;

  // public variables
  // List<OrderModel> orders = [];

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signUp(String firstName, String lastName, String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((user) {
        _userServices.createUser(firstName, lastName, email, password);
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(FirebaseUser user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      _userModel = await _userServices.getUserById(user.uid);
      print('the number of items in the cart is: ${userModel.cart.length}');
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future<void> updateUserModel() async {
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }

  Future<bool> addItemToCart({ProductsModel product, String size, int quantity}) async {
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List<CartModel> cartItems = _userModel.cart;
      double totalCartItemPrice = quantity * product.price;
      Map cartItem = {
        CartModel.ID: cartItemId,
        CartModel.NAME: product.name,
        CartModel.IMAGE: product.images[0],
        CartModel.PRODUCT_ID: product.id,
        CartModel.PRICE: totalCartItemPrice,
        CartModel.DELIVERY: product.delivery,
        CartModel.SHOPNAME: product.shopName,
        CartModel.TOTAL: totalCartItemPrice + product.delivery,
        CartModel.SIZE: size,
        CartModel.QUANTITY: quantity
      };
      print(cartItems.length);
      CartModel item = CartModel.fromMap(cartItem);
      _userServices.addToCart(userId: _user.uid, cartProduct: item);

      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future<bool> removeFromCart({CartModel cartItem}) async {
    try {
      _userServices.removeFromCart(userId: _user.uid, cartProduct: cartItem);
      return true;
    } catch (e) {
      print("error${e.toString()}");
      return false;
    }
  }
}
