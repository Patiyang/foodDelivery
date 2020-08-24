import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodDelivery/models/products.dart';

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
