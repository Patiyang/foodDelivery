import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodDelivery/models/products.dart';

class ProductsService {
  Firestore _firestore = Firestore.instance;
  String products = 'product';

  Future<List<ProductsModel>> fetchProducts() async {
    List<ProductsModel> productList = [];
    await _firestore.collection(products).getDocuments().then((snap) {
      for (DocumentSnapshot product in snap.documents) {
        productList.add(ProductsModel.fromSnapshot(product));
        print('the obtained document is this one ${productList[0].delivery}');
      }
    });
    return productList;
  }

  

  Future<List<ProductsModel>> fetchSearchProducts(String searchQuery) async {
    List<ProductsModel> searchList = [];
    await _firestore.collection(products).orderBy('name').startAt([searchQuery]).endAt([searchQuery + '\uf8ff']).getDocuments().then((snap) {
      for (DocumentSnapshot product in snap.documents) {
        searchList.add(ProductsModel.fromSnapshot(product));
      }
    });
    print('the length of the search list is'+searchList.length.toString());
    return searchList;
  }

  Future<void> updateProduct(String productId, String quantity) async {
    try {
      return _firestore.collection('product').document(productId).updateData({ProductsModel.QUANTITY: quantity});
    } catch (e) {
      print('THE ERROR WHILE UPDATING IS ' + e.toString());
    }
  }

  Future<List<ProductsModel>> selectedCartItem(String productId) async {
    List<ProductsModel> cartProductList = [];
    await _firestore.collection(products).where(ProductsModel.ID, isEqualTo: productId).getDocuments().then((snap) {
      for (DocumentSnapshot product in snap.documents) {
        cartProductList.add(ProductsModel.fromSnapshot(product));
        // print('the obtained document is this one ${cartProductList[0].delivery}');
      }
    });
    return cartProductList;
  }

  Future<List<ProductsModel>> fetchRecent() async {
    List<ProductsModel> productList = [];
    await _firestore.collection(products).orderBy('createdAt').getDocuments().then((snap) {
      snap.documents.forEach((snapshot) {
        productList.insert(0, ProductsModel.fromSnapshot(snapshot));
      });
    });
    return productList;
  }
}
