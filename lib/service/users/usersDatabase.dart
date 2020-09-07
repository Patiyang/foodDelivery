import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodDelivery/models/users.dart';
import 'package:uuid/uuid.dart';

class UserDataBase {
  Firestore _firestore = Firestore.instance;
  String users = 'users';
  FirebaseAuth auth = FirebaseAuth.instance;

  createUser(String firstName, String lastName, String emailAddress, String password, String uid) async {
    // FirebaseUser user = await auth.currentUser();
    try {
      return _firestore.collection(users).document(uid).setData({
        User.firstName: firstName,
        User.lastName: lastName,
        User.password: password,
        User.emailAddress: emailAddress,
        User.id: uid
      });
    } catch (e) {
      print(e.toString());
    }
  }

  deleteUser(String id) {
    try {
      // _firestore.collection(users).document().snapshots();
      return _firestore.collection(users).document(id).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  getUserByEmail(String email) {
    return _firestore.collection(users).where(User.emailAddress, isEqualTo: email).getDocuments();
  }
}
