import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodDelivery/models/cartProducts.dart';
import 'package:foodDelivery/models/users.dart';

class UserService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;

  Future<bool> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  createUser(String firstName, String lastName, String emailAddress, String password) async {
    FirebaseUser user = await _auth.currentUser();
    String uid = user.uid;
    try {
      return _firestore.collection('users').document(uid).setData({
        UserModel.FIRSTNAME: firstName,
        UserModel.LASTNAME: lastName,
        UserModel.PASSWORD: password,
        UserModel.EMAIL: emailAddress,
        UserModel.ID: user.uid
      });
    } catch (e) {
      print(e.toString());
    }
  }

  addToCart({String userId, CartModel cartProduct}) {
    _firestore.collection(UserModel.collection).document(userId).updateData({
      UserModel.CART: FieldValue.arrayUnion([cartProduct.toMap()])
    });
  }

  removeFromCart({String userId, CartModel cartProduct}) {
    _firestore.collection(UserModel.collection).document(userId).updateData({
      UserModel.CART: FieldValue.arrayRemove([cartProduct.toMap()])
    });
  }

  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<UserModel> getUserById(String id)=> _firestore.collection(UserModel.collection).document(id).get().then((doc){
    return UserModel.fromSnapshot(doc);
  });

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
