import 'package:flutter/material.dart';
import 'package:foodDelivery/screens/explore.dart';
import 'package:foodDelivery/screens/favorites/favorites.dart';
import 'package:foodDelivery/screens/orders.dart';
import 'package:foodDelivery/screens/profile.dart';
import 'package:foodDelivery/styling.dart';
import 'package:foodDelivery/widgets/customButton.dart';

enum Pages { home, orders, favorites, profile }

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final searchController = new TextEditingController();
  Pages _selectedPage = Pages.home;
  Color active = orange;
  Color inactive = black;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: loadScreen(),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                boxShadow: [BoxShadow(blurRadius: 1, color: grey[100], offset: Offset(2, 1))]),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomButton(
                  callback: () => setState(() {
                    _selectedPage = Pages.home;
                  }),
                  icon: Icons.home,
                  text: 'Explore',
                  color: _selectedPage == Pages.home ? orange : black,
                ),
                CustomButton(
                    callback: () => setState(() {
                          _selectedPage = Pages.orders;
                        }),
                    icon: Icons.shopping_cart,
                    text: 'My Orders',
                    color: _selectedPage == Pages.orders ? orange : black),
                CustomButton(
                    callback: () => setState(() {
                          _selectedPage = Pages.favorites;
                        }),
                    icon: Icons.bookmark,
                    text: 'Favorites',
                    color: _selectedPage == Pages.favorites ? orange : black),
                CustomButton(
                    callback: () => setState(() {
                          _selectedPage = Pages.profile;
                        }),
                    icon: Icons.person,
                    text: 'Profile',
                    color: _selectedPage == Pages.profile ? orange : black),
              ],
            )),
      ),
    );
  }

  Widget loadScreen() {
    switch (_selectedPage) {
      case Pages.home:
        return HomePage();
        break;
      case Pages.orders:
        return Orders();
        break;
      case Pages.favorites:
        return Favorites();
        break;
      case Pages.profile:
        return Profile();
      default:
        return Container();
    }
  }
}
