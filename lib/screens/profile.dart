import 'package:flutter/material.dart';
import 'package:foodDelivery/provider/userProvider.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        body: MaterialButton(
      onPressed: () {
        userProvider.signOut();
      },
      child: Text('logOut'),
    ));
  }
}
