import 'package:flutter/material.dart';
import 'package:foodDelivery/styling.dart';
import 'package:foodDelivery/widgets/title.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
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
                                hintText: 'Find food or hotel',
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
              child: CustomText(
                text: 'Discover New Places',
                size: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // the styling of the different restaurants lies here
            Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Column(
                    children: <Widget>[
                      Container(
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
                        child: Image.asset('images/res1.jpg', height: 200, width: 170, fit: BoxFit.fill),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
