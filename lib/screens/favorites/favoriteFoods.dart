import 'package:flutter/material.dart';
import 'package:foodDelivery/models/foods.dart';
import 'package:foodDelivery/styling.dart';
import 'package:foodDelivery/widgets/customText.dart';

class FavoriteFoods extends StatefulWidget {
  @override
  _FavoriteFoodsState createState() => _FavoriteFoodsState();
}

class _FavoriteFoodsState extends State<FavoriteFoods> {
  List<FoodList> favorites = [
    FoodList(
        hotelName: 'mbui',
        name: 'chapo madondo',
        image: 'C1.jpg',
        location: '1122 kimathi way',
        deliveryTime: '12 minutes',
        distance: '2km',
        description: 'this i'),
    FoodList(
        hotelName: 'shirikisho',
        name: 'ugali mayai',
        image: 'C2.jpg',
        location: '100m from kens hostel',
        deliveryTime: '12 minutes',
        distance: '2km',
        description: 'this is b'),
    FoodList(
        hotelName: 'vienna',
        name: 'rice mix',
        image: 'C3.jpg',
        location: '100m from kens hostel',
        deliveryTime: '12 minutes',
        distance: '2km',
        description: 'this is by '),
    FoodList(
        hotelName: 'greens hostel',
        name: 'ugali pork',
        image: 'C4.jpg',
        location: 'Junction stage',
        deliveryTime: '12 minutes',
        distance: '2km',
        description: 'this is by far '),
    FoodList(
        hotelName: 'kwa moseh',
        name: 'chai mandazi',
        image: 'C5.jpg',
        location: '100 metres from mt kenya hostels',
        deliveryTime: '12 minutes',
        distance: '2km',
        description: 'this is by far ')
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: favorites.length,
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
                      child: Image.asset('images/${favorites[index].image}', fit: BoxFit.cover, height: 120, width: 110),
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
                            child: CustomText(text: favorites[index].name, size: 17, maxLines: 1, fontWeight: FontWeight.bold),
                          ),
                          CustomText(text: favorites[index].hotelName),
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
                                  child: CustomText(maxLines: 2, text: favorites[index].location, color: grey),
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
        );
      },
    );
  }
}
