import 'package:flutter/material.dart';
import 'package:foodDelivery/models/restaurant.dart';
import 'package:foodDelivery/styling.dart';
import 'package:foodDelivery/widgets/title.dart';

class Restaurnats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<RestaurantList> restaurants = [
      RestaurantList(image: 'res1.jpg', hotelName: 'shirikisho', address: 'kimathi', delivery: true),
      RestaurantList(image: 'res2.jpg', hotelName: 'mbui hotel', address: 'lower dedan gate', delivery: true),
      RestaurantList(image: 'res3.jpg', hotelName: 'vienna hotel', address: '1099 kimathi way', delivery: false),
      RestaurantList(image: 'res4.jpg', hotelName: 'Annie\'s Place', address: '1122 Kingongo', delivery: true),
      RestaurantList(image: 'res5.jpg', hotelName: 'Fish Zone', address: 'Kings Market', delivery: true),
    ];

    return Container(height: 282,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: restaurants.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              constraints: BoxConstraints(maxWidth: 170, maxHeight: 281),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 0,
                            // color: orange,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Image.asset('images/${restaurants[index].image}', height: 200, width: 170, fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: 170, maxHeight: 30),
                    child: CustomText(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      text: '${restaurants[index].hotelName}',
                      color: black,
                      letterSpacing: 0,
                      size: 17,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: 170, maxHeight: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: CustomText(
                      text: '${restaurants[index].address}',
                          size: 14,
                          letterSpacing: 0,
                          overflow: TextOverflow.ellipsis,
                        )),
                        Material(
                          color: orange,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          child:restaurants[index].delivery==true? Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CustomText(
                              size: 10,
                              text: 'Free Delivery',
                              color: white,
                              letterSpacing: 0,
                            ),
                          ):SizedBox.shrink(),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
