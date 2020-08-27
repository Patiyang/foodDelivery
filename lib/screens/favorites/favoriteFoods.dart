import 'package:flutter/material.dart';
import 'package:foodDelivery/styling.dart';

class FavoriteFoods extends StatefulWidget {
  @override
  _FavoriteFoodsState createState() => _FavoriteFoodsState();
}

class _FavoriteFoodsState extends State<FavoriteFoods> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      // itemCount: favorites.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 1, offset: Offset(.5, .5), color: white)],
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        // child: Image.asset('images/${favorites[index].image}', fit: BoxFit.cover, height: 120, width: 110),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              // child: CustomText(text: favorites[index].name, maxLines: 1, fontWeight: FontWeight.bold),
                            ),
                            // CustomText(text: favorites[index].hotelName),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(Icons.location_on, size: 14, color: grey),
                                Expanded(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    // child: CustomText(maxLines: 2, text: favorites[index].location, color: grey),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.add_shopping_cart, color: orange, size: 17),
                            SizedBox(height: 20),
                            Icon(Icons.delete, color: Colors.red, size: 17),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
