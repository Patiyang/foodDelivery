import 'package:flutter/material.dart';
import 'package:foodDelivery/screens/manageOrders/cartScreen.dart';
import 'package:foodDelivery/screens/manageOrders/ordersScreen.dart';
import 'package:foodDelivery/widgets/customText.dart';
import 'package:foodDelivery/widgets/favoritesButton.dart';

import '../../styling.dart';

enum Pages { cartItems, orders }

class ManageOrders extends StatefulWidget {
  @override
  _ManageOrdersState createState() => _ManageOrdersState();
}

class _ManageOrdersState extends State<ManageOrders> {
  Pages selectedpage = Pages.cartItems;
  Color active = orange;
  Color inactive = grey[200];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 30,
        iconTheme: IconThemeData(color: black),
        // leading: IconButton(icon: Icon(Icons.clear), onPressed: ()=>Navigator.pop(context)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: CustomText(text: 'Manage Orders', size: 23, fontWeight: FontWeight.bold),
        elevation: 0,
        backgroundColor: white,
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 60,
                  color: white,
                  child: Center(
                    child: FavoriteButton(
                      color: selectedpage == Pages.cartItems ? active : inactive,
                      icon: Icons.shopping_basket,
                      text: 'Cart',
                      callback: () {
                        setState(() {
                          selectedpage = Pages.cartItems;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  color: white,
                  child: Center(
                      child: FavoriteButton(
                    color: selectedpage == Pages.orders ? active : inactive,
                    icon: Icons.monetization_on,
                    text: 'Orders',
                    callback: () {
                      setState(() {
                        selectedpage = Pages.orders;
                      });
                    },
                  )),
                ),
              ],
            ),
          ),
          Expanded(
            child: loadScreen(),
          ),
        ],
      ),
    );
  }

  Widget loadScreen() {
    switch (selectedpage) {
      case Pages.orders:
        return OrderItems();
        break;
      case Pages.cartItems:
        return CartScreen();
      default:
        return Container();
    }
  }
}
