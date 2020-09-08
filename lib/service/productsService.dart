import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodDelivery/models/cartProducts.dart';
import 'package:foodDelivery/models/products.dart';
import 'package:foodDelivery/models/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsService {
  Firestore _firestore = Firestore.instance;
  String products = 'product';

  Future<List<ProductsModel>> fetchProducts() async {
    List<ProductsModel> productList = [];
    await _firestore.collection(products).getDocuments().then((snap) {
      print(snap.runtimeType);
      for (DocumentSnapshot product in snap.documents) {
        productList.add(ProductsModel.fromSnapshot(product));
      }
    });
    return productList;
  }

  void addToCart({String userId, CartModel cartItem}) {
   _firestore.collection(UserModel.collection).document(userId).updateData({
      "cart": FieldValue.arrayUnion([cartItem.toMap()])
    });
  }

  Future<List<ProductsModel>> fetchCartProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString(UserModel.EMAIL);
    List<ProductsModel> productList = [];
    await _firestore.collection(UserModel.collection).document(id).collection(ProductsModel.CART).getDocuments().then((snap) {
      for (DocumentSnapshot product in snap.documents) {
        productList.add(ProductsModel.fromSnapshot(product));
      }
    });
    return productList;
  }

  Future<List<ProductsModel>> fetchRecent() async {
    List<ProductsModel> productList = [];
    await _firestore.collection(products).orderBy('time').getDocuments().then((snap) {
      snap.documents.forEach((snapshot) {
        productList.add(ProductsModel.fromSnapshot(snapshot));
      });
    });
    return productList;
  }
}
