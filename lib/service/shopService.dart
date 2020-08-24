import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodDelivery/models/shops.dart';

class ShopService{
  Firestore _firestore = Firestore.instance;
  String users = 'users';

  Future<List<ShopModel>> fetchProducts() async {
    List<ShopModel> shopList = [];
    await _firestore.collection(users).getDocuments().then((snap) {
      print(snap.runtimeType);
      for (DocumentSnapshot shop in snap.documents) {
        shopList.add(ShopModel.fromSnapshot(shop));
      }
    });
    return shopList;
  }
}