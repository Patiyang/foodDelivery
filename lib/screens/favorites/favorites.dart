import 'package:flutter/material.dart';
import 'package:foodDelivery/screens/favorites/favoriteFoods.dart';
import 'package:foodDelivery/styling.dart';
import 'package:foodDelivery/widgets/customText.dart';
import 'package:foodDelivery/widgets/favoritesButton.dart';

import 'FavoritePlaces.dart';

enum Pages { places, foods }

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  Pages selectedpage = Pages.places;
  Color active = orange;
  Color inactive = grey[200];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: CustomText(text: 'My Favorites', size: 23, fontWeight: FontWeight.bold),
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
                      color: selectedpage == Pages.places ? active : inactive,
                      icon: Icons.restaurant,
                      text: 'Places',
                      callback: () {
                        setState(() {
                          selectedpage = Pages.places;
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
                    color: selectedpage == Pages.foods ? active : inactive,
                    icon: Icons.fastfood,
                    text: 'Foods',
                    callback: () {
                      setState(() {
                        selectedpage = Pages.foods;
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
      case Pages.places:
        return FavoritePlaces();
        break;
      case Pages.foods:
        return FavoriteFoods();
      default:
        return Container();
    }
  }
}
