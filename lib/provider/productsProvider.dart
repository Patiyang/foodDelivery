import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodDelivery/models/cartProducts.dart';
import 'package:foodDelivery/models/products.dart';
import 'package:foodDelivery/models/users.dart';
import 'package:foodDelivery/service/productsService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ProductsProvider with ChangeNotifier {
  ProductsService _productsService = new ProductsService();
  List<ProductsModel> products = [];
  List<ProductsModel> productsSearched = [];
  List<ProductsModel> cartProducts = [];
  List<ProductsModel> wishListProducts = [];
  ProductsModel _productsModel;
  ProductsModel get productsModel => _productsModel;
  final FirebaseAuth auth = FirebaseAuth.instance;

  ProductsProvider.initialize() {
    loadProducts();
    loadCart();
  }

  loadProducts() async {
    products = await _productsService.fetchProducts();
    notifyListeners();
  }

  loadCart() async {
    cartProducts = await _productsService.fetchCartProducts();
    notifyListeners();
  }

  Future<bool> addToCart({ProductsModel productItem, String size}) async {
    FirebaseUser user = await auth.currentUser();
    print('THE USER ID IS${user.uid}');
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      // List<CartModel> cartItems = _productsModel.cartList;

      Map cartProduct = {
        'id': cartItemId,
        'productId': productItem.id,
        'name': productItem.name,
        'image': productItem.images[0],
        'shopName': productItem.shopName,
        'delivery': productItem.delivery,
        'price': productItem.price,
        'size': size
      };
      CartModel cartItem = CartModel.fromMap(cartProduct);
      // print("CART ITEMS ARE: ${cartItems.length}");
      _productsService.addToCart(userId: user.uid, cartItem: cartItem);
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }
}
