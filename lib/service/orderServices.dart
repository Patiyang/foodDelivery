import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodDelivery/models/cartProducts.dart';
import 'package:foodDelivery/models/orders.dart';

class OrderServices {
  Firestore _firestore = Firestore.instance;
  String collection = 'orders';
  createOrder({String userId, String id, String description, String status, double totalPrice, List<CartModel> cart, String shopName}) {
    List<Map> convertedCart = [];

    for (CartModel item in cart) {
      convertedCart.add(item.toMap());
    }

    _firestore.collection(collection).document(id).setData({
      "userId": userId,
      "id": id,
      "cart": convertedCart,
      "total": totalPrice,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "description": description,
      "status": status
    });
  }

  Future<List<OrderModel>> getUserOrders({String userId}) async =>
      _firestore.collection(collection).where("userId", isEqualTo: userId).getDocuments().then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot order in result.documents) {
          orders.add(OrderModel.fromSnapshot(order));
        }
        return orders;
      });
}
