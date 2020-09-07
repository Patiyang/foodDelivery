import 'package:flutter/material.dart';
import 'package:foodDelivery/models/shops.dart';
import 'package:foodDelivery/provider/shopProvider.dart';
import 'package:foodDelivery/screens/shops/singleShop.dart';
import 'package:foodDelivery/styling.dart';
import 'package:foodDelivery/widgets/customText.dart';
import 'package:foodDelivery/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class Restaurnats extends StatefulWidget {
  @override
  _RestaurnatsState createState() => _RestaurnatsState();
}

class _RestaurnatsState extends State<Restaurnats> {
  @override
  Widget build(BuildContext context) {
    final shopProvider = Provider.of<ShopProvider>(context);
    print(shopProvider.shops.length);
    return Container(
      height: 282,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: shopProvider.shops.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SingleShop(
                    shopModel: shopProvider.shops[index],
                  ),
                )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: Container(
                // height: 281,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: grey[400],
                      offset: Offset(2, 2),
                      blurRadius: 3,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: ShopsCard(
                  shopModel: shopProvider.shops[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ShopsCard extends StatelessWidget {
  final ShopModel shopModel;

  const ShopsCard({Key key, this.shopModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(9)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      color: orange,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Loading(),
                    FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: shopModel.backgroundImage,
                      height: 200,
                      width: 178,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
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
                  text: shopModel.name,
                  color: black,
                  letterSpacing: 0,
                  size: 17),
            ),
            SizedBox(
              height: 6,
            ),
            Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 170, maxHeight: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.location_on, size: 17),
                    CustomText(text: shopModel.location, size: 14, letterSpacing: 0, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
