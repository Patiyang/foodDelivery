import 'package:flutter/material.dart';
import 'package:foodDelivery/screens/home.dart';
import 'package:foodDelivery/screens/favorites/favorites.dart';
import 'package:foodDelivery/screens/orders.dart';
import '../styling.dart';
import 'profile.dart';

class HomeNavigation extends StatefulWidget {
  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final tabs = [HomePage(), ManageOrders(), Favorites(), Profile()];
    return SafeArea(
      child: Scaffold(
        body: tabs[currentIndex],
        bottomNavigationBar: SizedBox(
          height: 45,
          child: BottomNavigationBar(
            unselectedLabelStyle: TextStyle(color: black),
            fixedColor: orange,
            unselectedItemColor: black,
            selectedFontSize: 12,
            unselectedFontSize: 10,
            elevation: 0,
            iconSize: 15,
            showUnselectedLabels: true,
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), title: Text('Manage Orders')),
              BottomNavigationBarItem(icon: Icon(Icons.bookmark), title: Text('Favorites')),
              BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Profile')),
            ],
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
