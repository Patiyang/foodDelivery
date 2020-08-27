import 'package:flutter/material.dart';
import 'package:foodDelivery/screens/products/recentProducts.dart';
import 'package:foodDelivery/screens/shops/recentShops.dart';
import 'package:foodDelivery/widgets/customText.dart';

import '../styling.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    //here is the styling of the search bar
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), boxShadow: [
                        BoxShadow(blurRadius: 2, color: grey[100], offset: Offset(1, 1)),
                      ]),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search Products or Shops',
                              hintStyle: TextStyle(color: grey),
                            ),
                            style: TextStyle(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: grey[100],
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: IconButton(icon: Icon(Icons.filter_list), onPressed: () {})),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width - 16,
              child: Row(
                children: <Widget>[
                  CustomText(
                    text: 'Discover New Places',
                    size: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  Spacer(),
                  GestureDetector(child: Icon(Icons.arrow_forward_ios))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Restaurnats(),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width - 16,
              child: Row(
                children: <Widget>[
                  CustomText(
                    text: 'Latest Products',
                    size: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  Spacer(),
                  GestureDetector(child: Icon(Icons.arrow_forward_ios))
                ],
              ),
            ),
          ),
          RecentProducts(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width - 16,
              child: Row(
                children: <Widget>[
                  CustomText(
                    text: 'Recommended Products',
                    size: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  Spacer(),
                  GestureDetector(child: Icon(Icons.arrow_forward_ios))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  
}
