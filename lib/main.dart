import 'package:flutter/material.dart';
import 'package:foodDelivery/styling.dart';

import 'screens/loginSignUp/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // scaffoldBackgroundColor: white,
        cursorColor: black,
        accentColor: orange,
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(),
    );
  }
}
