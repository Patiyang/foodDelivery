import 'package:flutter/material.dart';
import 'package:foodDelivery/models/restaurant.dart';
import 'package:foodDelivery/styling.dart';
import 'package:foodDelivery/widgets/customText.dart';

class FavoritePlaces extends StatefulWidget {
  @override
  _FavoritePlacesState createState() => _FavoritePlacesState();
}

class _FavoritePlacesState extends State<FavoritePlaces> {
  List<RestaurantList> favorites = [
    RestaurantList(image: 'res1.jpg', hotelName: 'shirikisho', address: 'kimathi', delivery: true),
    RestaurantList(image: 'res2.jpg', hotelName: 'mbui hotel', address: 'lower dedan gate', delivery: true),
    RestaurantList(image: 'res3.jpg', hotelName: 'Vienna hotel', address: '1099 kimathi way', delivery: false),
    RestaurantList(image: 'res4.jpg', hotelName: 'Patto\'s Place', address: '1122 Kingongo', delivery: true),
    RestaurantList(image: 'res5.jpg', hotelName: 'Fish Zone', address: 'Kings Market', delivery: true),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: favorites.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(9)),
              color: white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: grey[300],
                  offset: Offset(1, 1),
                )
              ],
            ),
            margin: EdgeInsets.all(8),
            height: 100,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child: Image.asset('images/${favorites[index].image}', fit: BoxFit.cover, height: 80, width: 80),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 128,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: CustomText(
                                  maxLines: 2, text: favorites[index].hotelName, size: 17, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.bookmark, color: Colors.indigo)
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 128,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: grey,
                            ),
                            Expanded(
                              child: CustomText(maxLines: 2, text: favorites[index].address, color: grey),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 128,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: favorites[index].delivery == true
                                  ? Material(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                                      color: orange,
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
                                          child: CustomText(
                                              size: 13,
                                              text: 'Free Delivery',
                                              color: white,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.bold)))
                                  : SizedBox.shrink(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Icon(Icons.delete),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
