import 'package:flutter/material.dart';
import 'package:foodDelivery/models/shops.dart';

class SingleShop extends StatefulWidget {
  final ShopModel shopModel;

  const SingleShop({Key key, this.shopModel}) : super(key: key);
  @override
  _SingleShopState createState() => _SingleShopState();
}

class _SingleShopState extends State<SingleShop> {
  @override
  Widget build(BuildContext context) {
    var singleShop = widget.shopModel;
    return Scaffold(
      appBar: AppBar(elevation: 0,
        centerTitle: true,
        title: Hero(
          tag: 'shopName',
          child: Text(singleShop.name)),
      ),
      body: ListView(
        shrinkWrap: true,
        addAutomaticKeepAlives: false,
        children: [
          SizedBox(
            height: 150.0,
            width: 300.0,
            // child: Hero(child: Text()),
          ),
        ],
      ),
    );
  }
}
