import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodDelivery/models/cartProducts.dart';
import 'package:foodDelivery/models/users.dart';
import 'package:foodDelivery/service/users/usersDatabase.dart';

class UserService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;
  UserDataBase userDataBase = UserDataBase();

  User _firebaseUser(FirebaseUser user) {
    return user != null ? User(userId: user.uid) : null;
  }

  Future<bool> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future signUp(String email, String password, String firstName, String lastName) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((user) {
        userDataBase.createUser(firstName, lastName, email, password, user.user.uid);
        // return null;
      });
      // FirebaseUser firebaseUser = result.user;
      // return _firebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      // return false;
    }
  }

  addToCart({String userId, CartModel cartProduct}) {
    _firestore.collection(User.collection).document(userId).updateData({
      'cart': FieldValue.arrayUnion([cartProduct.toMap()])
    });
  }

  removeFromCart({String userId, CartModel cartProduct}) {
    _firestore.collection(User.collection).document(userId).updateData({
      'cart': FieldValue.arrayRemove([cartProduct.toMap()])
    });
  }

  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
