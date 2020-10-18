import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodDelivery/models/products.dart';
import 'package:foodDelivery/screens/products/singleProduct.dart';
import 'package:foodDelivery/service/productsService.dart';
import 'package:foodDelivery/widgets/changeScreen.dart';
import 'package:foodDelivery/widgets/customButton.dart';
import 'package:foodDelivery/widgets/customText.dart';
import 'package:foodDelivery/widgets/loading.dart';

import '../styling.dart';

class SearchScreen extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      textTheme: TextTheme(headline6: TextStyle(color: Colors.white, fontSize: 17)),
      accentIconTheme: IconThemeData(color: grey),
      inputDecorationTheme: InputDecorationTheme(hintStyle: TextStyle(color: Colors.white)),
      primaryColor: grey,
      hintColor: Colors.yellow,
      primaryIconTheme: IconThemeData(color: Colors.white),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ProductsService productsService = new ProductsService();

    return StreamBuilder(
      stream: productsService.fetchSearchProducts(query).asStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          print('snapshot has data');
          List<ProductsModel> products = snapshot.data;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Image.network(
                  products[index].images[0],
                  height: 50,
                  width: 50,
                ),
                title: CustomText(text: products[index].name, maxLines: 1, overflow: TextOverflow.fade),
                subtitle: CustomText(text: products[index].description, maxLines: 2, overflow: TextOverflow.fade),
                trailing: CustomButton(
                    callback: () => changeScreenReplacement(
                        context,
                        SingleProduct(
                          productsModel: products[index],
                        )),
                    icon: Icons.arrow_right,
                    text: 'View'),
              );
            },
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading(
            text: 'Please wait ...',
          );
        }
        if (snapshot.connectionState == ConnectionState.none) {
          return CustomText(text: 'UNABLE TO CONNECT');
        }
        if (snapshot.hasError) {
          return Loading(
            text: snapshot.error,
          );
        }
        return Container();
      },
    );
  }
}
