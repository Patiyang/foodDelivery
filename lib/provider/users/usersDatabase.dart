import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodDelivery/models/users.dart';

class UserDataBase {
  Firestore _firestore = Firestore.instance;
  String users = 'users';

  createUser(String firstName, String lastName, String userName, String emailAddress, String password, String phoneNumber) {
    try {
      return _firestore.collection(users).document().setData({
        User.firstName: firstName,
        User.lastName: lastName,
        User.password: password,
        User.userName: userName,
        User.phoneNumber: phoneNumber
      });
    } catch (e) {
      print(e.toString());
    }
  }

  getUserByEmail(String email) {
    return _firestore.collection(users).where('email', isEqualTo: email).getDocuments();
  }
}
