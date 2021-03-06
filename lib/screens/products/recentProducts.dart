import 'package:flutter/material.dart';
import 'package:foodDelivery/provider/productsProvider.dart';
import 'package:foodDelivery/screens/products/singleProduct.dart';
import 'package:foodDelivery/styling.dart';
import 'package:foodDelivery/widgets/customText.dart';
import 'package:foodDelivery/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class RecentProducts extends StatefulWidget {
  @override
  _RecentProductsState createState() => _RecentProductsState();
}

class _RecentProductsState extends State<RecentProducts> {
  String email = '';

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    print('the length is ${productProvider.products.length}');
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: productProvider.products.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => SingleProduct(
                                    productsModel: productProvider.products[index],
                                  ))),
                      child: Container(
                        // padding: EdgeInsets.symmetric(horizontal:4),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                              color: grey[400],
                              offset: Offset(2, 2),
                              blurRadius: 3,
                              spreadRadius: 1
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Hero(
                              tag: '${productProvider.products[index].id}',
                              child: CustomText(
                                text: productProvider.products[index].name,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Loading(),
                                      FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage,
                                        image: productProvider.products[index].images[1],
                                        width: 150,
                                        fit: BoxFit.cover,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Row(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomText(
                                      text: 'Status:${productProvider.products[index].status}',
                                      size: 12,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                // Divider(color: black),
                                CustomText(
                                  fontWeight: FontWeight.bold,
                                  color: orange,
                                  text: 'Kes: ${productProvider.products[index].price}',
                                  size: 12,
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Material(
                                  color: orange,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(text: 'Delivery:'),
                                      TextSpan(
                                          text: '${productProvider.products[index].delivery}',
                                          style: TextStyle(fontWeight: FontWeight.bold))
                                    ])),
                                  )),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.location_on, size: 14, color: grey),
                                CustomText(
                                  text: '${productProvider.products[index].location}',
                                  textAlign: TextAlign.center,
                                  size: 12,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
