import 'package:flutter/material.dart';
import 'package:foodDelivery/models/users.dart';
import 'package:foodDelivery/service/users/userProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginSignUp/login.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserService userProvider = new UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MaterialButton(
      onPressed: 
      logout,
      // () async {
      //   SharedPreferences preferences = await SharedPreferences.getInstance();
      //   String email = preferences.getString(User.email);
      //   print(email);
      // },
      child: Text('data'),
    ));
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userProvider.signOut().then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Login())));
    setState(() {
      prefs.setString(User.emailAddress, '');
    });
  }
}
