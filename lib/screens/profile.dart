import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodDelivery/models/users.dart';
import 'package:foodDelivery/provider/userProvider.dart';
import 'package:foodDelivery/service/userService.dart';
import 'package:foodDelivery/styling.dart';
import 'package:foodDelivery/widgets/customText.dart';
import 'package:foodDelivery/widgets/loading.dart';
import 'package:provider/provider.dart';

import 'manageOrders/cartScreen.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final _formKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  final _userName = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _emailAddress = TextEditingController();
  final _currentPassword = TextEditingController();
  final _newPassword = TextEditingController();
  String _oldPassword = '';
  bool hidePassword = true;
  bool hideNewPassword = true;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    Firestore _firestore = Firestore.instance;

    UserService userService = new UserService();

    String users = 'users';
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('Profile Management'),
        backgroundColor: orange,
        centerTitle: true,
        actions: <Widget>[
          // IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
              })
        ],
      ),
      body: StreamBuilder(
        stream: _firestore.collection(users).where(UserModel.ID, isEqualTo: user.user.uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data.documents.length; i++) {
              DocumentSnapshot _snap = snapshot.data.documents[i];
              _firstName.text = _snap[UserModel.FIRSTNAME];
              _lastName.text = _snap[UserModel.LASTNAME];
              // _userName.text = _snap[UserModel.USERNAME];
              _phoneNumber.text = _snap[UserModel.PHONE];
              _emailAddress.text = _snap[UserModel.EMAIL];
              _oldPassword = _snap[UserModel.PASSWORD];
            }
            return ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    height: 20,
                    child: CustomText(
                      text: 'Personal Details',
                    )),
                Divider(),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: TextFormField(
                      //     controller: _userName,
                      //     decoration:
                      //         InputDecoration(labelText: 'Username', icon: Icon(Icons.person_add), border: InputBorder.none),
                      //     validator: (value) {
                      //       if (value.isEmpty) return 'UserName field cannot be empty';

                      //       return null;
                      //     },
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _firstName,
                          decoration: InputDecoration(icon: Icon(Icons.person), border: InputBorder.none, labelText: 'firstName'),
                          validator: (value) {
                            if (value.isEmpty) return 'firstName field cannot be empty';

                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _lastName,
                          decoration:
                              InputDecoration(labelText: 'lastName', icon: Icon(Icons.person_add), border: InputBorder.none),
                          validator: (value) {
                            if (value.isEmpty) return 'lastName field cannot be empty';

                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _phoneNumber,
                          decoration:
                              InputDecoration(labelText: 'phoneNumber', icon: Icon(Icons.phone), border: InputBorder.none),
                          validator: (value) {
                            if (value.isEmpty) return 'phoneNumber field cannot be empty';

                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _emailAddress,
                          decoration:
                              InputDecoration(labelText: 'emailAddress', icon: Icon(Icons.mail), border: InputBorder.none),
                          readOnly: true,
                        ),
                      ),
                      MaterialButton(
                        color: orange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        minWidth: MediaQuery.of(context).size.width * .8,
                        child: CustomText(
                          text: 'Save info',
                        ),
                        onPressed: () async {
                          print(_userName.text);
                          if (_formKey.currentState.validate()) {
                            await userService
                                .updateUser(user.user.uid, _firstName.text, _lastName.text, _phoneNumber.text, user.user.uid)
                                .then((_) => _key.currentState.showSnackBar(
                                      SnackBar(
                                          content: Text(
                                        'Data saved',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: white),
                                      )),
                                    ));
                          }
                        },
                      ),
                      Divider(),
                      Container(alignment: Alignment.centerLeft, height: 20, child: CustomText(text: 'Manage Passwords')),
                      Divider(),
                    ],
                  ),
                ),
                Form(
                    key: _passwordKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _currentPassword,
                            obscureText: hidePassword,
                            decoration: InputDecoration(
                                suffixIcon: Stack(
                                  children: <Widget>[
                                    Visibility(
                                      visible: hidePassword == true,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.lock,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            hidePassword == true ? hidePassword = false : hidePassword = true;
                                          });
                                        },
                                      ),
                                    ),
                                    Visibility(
                                      visible: hidePassword == false,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.lock_open,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            hidePassword == false ? hidePassword = true : hidePassword = false;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                labelText: 'Old Password',
                                icon: Icon(Icons.lock_outline),
                                border: InputBorder.none),
                            validator: (value) {
                              if (value.isEmpty) return 'password cannot be empty';
                              if (value.length < 6) return 'password has to be at least 6 characters';
                              if (value != _oldPassword) return 'Password does not match your current password';
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _newPassword,
                            obscureText: hideNewPassword,
                            decoration: InputDecoration(
                                suffixIcon: Stack(
                                  children: <Widget>[
                                    Visibility(
                                      visible: hideNewPassword == true,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.lock,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            hideNewPassword == false ? hideNewPassword = true : hideNewPassword = false;
                                          });
                                        },
                                      ),
                                    ),
                                    Visibility(
                                      visible: hideNewPassword == false,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.lock_open,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            hideNewPassword == false ? hideNewPassword = true : hideNewPassword = false;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                hintText: 'New Password',
                                icon: Icon(Icons.lock_outline),
                                border: InputBorder.none),
                            validator: (value) {
                              if (value.isEmpty) return 'password cannot be empty';
                              if (value.length < 6) return 'password has to be at least 6 characters';
                              return null;
                            },
                          ),
                        ),
                        MaterialButton(
                          color: orange,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          minWidth: MediaQuery.of(context).size.width * .8,
                          child: CustomText(
                            text: 'Update Password',
                          ),
                          onPressed: () async {
                            print(_oldPassword);
                            if (_passwordKey.currentState.validate()) {
                              await userService
                                  .updatePassword(_newPassword.text, user.user.uid)
                                  .then((_) => _key.currentState.showSnackBar(
                                        SnackBar(
                                            content: CustomText(
                                          text: 'Password Updated',
                                          textAlign: TextAlign.center,
                                        )),
                                      ));
                            }
                          },
                        ),
                      ],
                    ))
              ],
            );
          }
          return Loading();
        },
      ),
    );
  }
}
