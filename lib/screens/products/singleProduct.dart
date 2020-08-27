import 'package:flutter/material.dart';
import 'package:foodDelivery/models/products.dart';

class SingleProduct extends StatefulWidget {
  final ProductsModel productsModel;

  const SingleProduct({Key key, this.productsModel}) : super(key: key);
  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    var singleProduct = widget.productsModel;
    return Scaffold(
      appBar: AppBar(elevation: 0,
        centerTitle: true,
        title: Hero(
          tag: 'name',
          child: Text(singleProduct.name)),
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
